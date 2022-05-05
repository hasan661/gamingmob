import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/models/blog.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:gamingmob/blogs/widgets/addblogsitem.dart';
import 'package:provider/provider.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);
  static const routeName = "/addblogs";

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  
  List<Map<String, String>> listOfBlogContent = [];
  File? homeScreenImage;
  String title="";
  String homeImageUrl="";
  

  listofBlogContentAssigner(Map<String, String> a) {
    setState(() {
      listOfBlogContent.add(a);
    });
  }
  titleAssigner(String blogHomeTitle){
    setState(() {
      title=blogHomeTitle;
    });


  }

  homeImageAssigner(File homeImage){
    setState(() {
      homeScreenImage=homeImage;
    });
  }
  postContent()async{
    var currentUser=FirebaseAuth.instance.currentUser;
    var userID= currentUser!.uid;
    var userName=currentUser.displayName;
    var fireStorgaeObj=FirebaseStorage.instance.ref();
    var homeImageReference=fireStorgaeObj.child(
            "GamingMob/BlogsHome/${homeScreenImage!.path + title}");
    await homeImageReference.putFile(File(homeScreenImage!.path));
    
    
    homeImageUrl=await homeImageReference.getDownloadURL();

    for(int i=0;i<listOfBlogContent.length;i++){
      if(listOfBlogContent[i]["type"]=="image"){
        var contentImageReference=fireStorgaeObj.child("GamingMob/BlogsContent/${listOfBlogContent[i]["data"]}");
      await contentImageReference.putFile(File(listOfBlogContent[i]["data"].toString()));
       var url=await contentImageReference.getDownloadURL();
       listOfBlogContent[i]["data"]=url;
      }
      

    }
    var item=Blog(id: "", blogContent: BlogContent(listOfBlogContent), imageURL: homeImageUrl, title: title, blogCreationDate: Timestamp.now(), userId: userID, userName: userName??"");

    Provider.of<BlogProvider>(context, listen: false).addBlogs(item);
    


  }

 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blogs"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                postContent();

              },
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: AddBlogsItem(
        listOfBlogContent: listOfBlogContent,
        assigner: listofBlogContentAssigner,
        homeImageAssigner: homeImageAssigner,
        homeTitle: titleAssigner,

      ),
    );
  }
}
