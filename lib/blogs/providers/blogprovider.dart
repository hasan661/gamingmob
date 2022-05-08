import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/blogs/models/blog.dart';

class BlogProvider with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get allBlogs {
    return _blogs;
  }

  Future<void> fetchBlogs() async {
    try{
    List<Blog> fetchedBlogs = [];
    var blogObj = await FirebaseFirestore.instance
        .collection("Blogs")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .first;
    var objDocks = blogObj.docs;
    for (var element in objDocks) {
      fetchedBlogs.add(
        Blog(
        
          id: element.id,
          blogContent: BlogContent(element["content"]),
          imageURL: element["imageURL"],
          title: element["title"],
          blogCreationDate: (element["createdAt"] as Timestamp).toDate(),
          userId: element["userID"],
          userName: element["userName"],
          
        ),
      );
    }
    _blogs = fetchedBlogs;
    }
    catch(e){
      print(e);
    }
  }

  Future<void> addBlogs(Blog item) async {
    FirebaseFirestore.instance.collection("Blogs").doc().set({
      "content": item.blogContent.content,
      "createdAt": item.blogCreationDate,
      "imageURL": item.imageURL,
      "title": item.title,
      "userID": item.userId,
      "userName": item.userName
    });
    _blogs.add(item);
    notifyListeners();
  }

  Blog getById(String id) {
    // print(id);
    var a = _blogs.firstWhere((element) {
      return element.id == id;
    });

    return a;
  }

  List<Blog> getListById() {
    return _blogs
        .where((element) =>
            element.userId == FirebaseAuth.instance.currentUser!.uid)
        .toList();
  }

  Future<void> removeABlog(id) async {
    print(id);
    try{
      FirebaseFirestore.instance.doc("Blogs/$id").delete();
    _blogs.removeWhere((element) => element.id == id);
    notifyListeners();
    }
    catch(E){
      print(E.toString()+"hasan");
    }
  }
}
