import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/blogs/models/blog.dart';

class BlogProvider with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get allBlogs {
    var id = FirebaseAuth.instance.currentUser!.uid;
    return _blogs.where((element) => element.userId != id).toList();
  }

  Future<void> fetchBlogs() async {
    try {
      List<Blog> fetchedBlogs = [];
      var blogObj = await FirebaseFirestore.instance
          .collection("Blogs")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .first;
      var objDocks = blogObj.docs;
      for (var element in objDocks) {
        List<BlogContent> list = [];
        element["content"].forEach((el) {
          list.add(BlogContent(data: el["data"], type: el["type"]));
        });

        fetchedBlogs.add(
          Blog(
            id: element.id,
            blogContent: list,
            imageURL: element["imageURL"],
            title: element["title"],
            blogCreationDate: (element["createdAt"] as Timestamp).toDate(),
            userId: element["userID"],
            userName: element["userName"],
          ),
        );
      }
      _blogs = fetchedBlogs;
    } catch (e) {
      print(e.toString() + "hasan");
    }
  }

  Future<void> addBlogs(Blog item) async {
      FirebaseFirestore.instance.collection("Blogs").doc().set({
      "content": item.blogContent
          .map((e) => {"data": e.data, "type": e.type})
          .toList(),
      "createdAt": item.blogCreationDate,
      "imageURL": item.imageURL,
      "title": item.title,
      "userID": item.userId,
      "userName": item.userName
    });
   
    // _blogs.add(item);
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
    try {
      FirebaseFirestore.instance.doc("Blogs/$id").delete();
      _blogs.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (E) {
      print(E.toString() + "hasan");
    }
  }
  Future<void> updateBlog(Blog newBlog) async{
    print(newBlog.id.toString()+"asahasan");
    
   try{
      FirebaseFirestore.instance.collection("Blogs").doc(newBlog.id).update({
      "imageURL": newBlog.imageURL,
      "title":newBlog.title,
      "content":newBlog.blogContent
          .map((e) => {"data": e.data, "type": e.type})
          .toList()
     
    });
   }
   catch(E){
     print(E);
   }
    
    notifyListeners();
  }
}
