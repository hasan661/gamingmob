import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/blogs/models/blog.dart';

class BlogProvider with ChangeNotifier{
  List<Blog> _blogs= [

  ];

  List<Blog> get allBlogs{
    return _blogs;
  }

  Future<void> fetchBlogs()async{
   
      List<Blog> fetchedBlogs=[];
    var blogObj= await FirebaseFirestore.instance.collection("Blogs").snapshots().first;
    var objDocks=blogObj.docs;
    for(var element in objDocks){
      fetchedBlogs.add(Blog(id: element.id, blogContent: element["content"], imageURL: element["imageURL"], title: element["title"], blogCreationDate: element["createdAt"]));
      
    }
    _blogs=fetchedBlogs;
   





  }

  



}