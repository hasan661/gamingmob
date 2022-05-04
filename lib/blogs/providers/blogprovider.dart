import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/blogs/models/blog.dart';

class BlogProvider with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get allBlogs {
    return _blogs;
  }

  Future<void> fetchBlogs() async {
    List<Blog> fetchedBlogs = [];
    List<Map<String, String>> listOfBlogContent = [];
    var blogObj =
        await FirebaseFirestore.instance.collection("Blogs").snapshots().first;
    var objDocks = blogObj.docs;
    try {
      for (var element in objDocks) {
        for(var e in element["content"]){
           listOfBlogContent.add({
          "data": e["data"],
          "type": e["type"]
        });
        }
        fetchedBlogs.add(
          Blog(
              id: element.id,
              blogContent: BlogContent(listOfBlogContent),
              imageURL: element["imageURL"],
              title: element["title"],
              blogCreationDate: element["createdAt"],
              userId: element["userID"],
              userName: element["userName"]),
        );
      }
      _blogs = fetchedBlogs;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addBlogs(Blog item)async{
    FirebaseFirestore.instance.collection("Blogs").doc().set({
      "content":item.blogContent.content,
      "createdAt":item.blogCreationDate,
      "imageURL":item.imageURL,
      "title":item.title,
      "userID":item.userId,
      "userName":item.userName
      
              

    });
    _blogs.add(item);
    notifyListeners();
    

  }

  // Future testing() async {
  //   try {
  //     var data = await FirebaseFirestore.instance
  //         .collection("testingwidget")
  //         .get()
  //         .then((value) {
  //       var a = value.docs;

  //       return a.first.data();
  //     });
  //   } catch (e) {
  //     print(e.toString() + "hasan");
  //   }
  // }
}
