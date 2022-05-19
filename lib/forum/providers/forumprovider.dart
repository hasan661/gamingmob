import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/forum/models/forum.dart';

class ForumProvider with ChangeNotifier {
  List<Forum> _forumsList = [];

  List<Forum> get forums {
    return _forumsList;
  }

  Future<void> fetchForums() async {
    try {
      List<Forum> fetchedForums = [];

      var forumObj = await FirebaseFirestore.instance
          .collection("Forums")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .first;
      // var objDocks = ;
      for (var element in forumObj.docs) {
        var comments =await FirebaseFirestore.instance.collection("Forums").doc(element.id).collection("comments").snapshots().first;
        List<Comments> commentss = [];
        List<String> likes = [];
        for (var e in comments.docs) {
          // List<Comments> subComments=[];
          // e["comments"].forEach((ele){
          //   subComments.add(Comments(commentID: element.id + e["commentUserID"]+ e["commentUserID"], commentUserId: ele["commentUserID"], commentUserName: ele["commentUserName"],
          //     commentContent: ele["commentContent"],
          //     commentedAt: (ele["commentedAt"] as Timestamp).toDate(),));
          // });
      
          commentss.add(
            Comments(
              comments: [],
            
              commentID: e.id,
              commentUserId: e["commentUserId"],
              commentUserName: e["commentUserName"],
              commentContent: e["commentContent"],
              commentedAt: (e["commentedAt"] as Timestamp).toDate(),
              commentedUserImage: e["commentedUserImageUrl"]
            ),
          );
        }
        element["likeList"].forEach((e) {
          likes.add(e);
        });

        fetchedForums.add(Forum(
            comments: commentss,
            forumId: element.id,
            userID: element["userId"],
            userName: element["userName"],
            forumText: element["forumText"],
            likeList: likes,
            imageURL: element["imageURL"],
            createdAt: (element["createdAt"] as Timestamp).toDate(),
            userImageUrl: element["userImageUrl"] == "null"
                ? null
                : element["userImageUrl"]));
      }
      _forumsList = fetchedForums;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addForum(Forum forum) async {
    var currentUser = FirebaseAuth.instance.currentUser;
   
      await FirebaseFirestore.instance.collection("Forums").doc().set({
      'userId': currentUser!.uid,
      'comments': forum.comments,
      'forumText': forum.forumText,
      'likeList': forum.likeList,
      'imageURL': forum.imageURL,
      'createdAt': forum.createdAt,
      'userImageUrl': currentUser.photoURL,
      'userName': currentUser.displayName,
    
    });
   

    // _forumsList.add(Forum(
    //     comments: forum.comments,
    //     forumId: forum.forumId,
    //     userID: currentUser.uid,
    //     userName: currentUser.displayName ?? "",
    //     forumText: forum.forumText,
    //     likeList: forum.likeList,
    //     imageURL: forum.imageURL,
    //     createdAt: forum.createdAt,
    //     userImageUrl: currentUser.photoURL));
    notifyListeners();
  }
  Future<void> updateForum(forumID ,Forum forum)async{
    var user=FirebaseAuth.instance.currentUser;
     FirebaseFirestore.instance.collection("Forums").doc(forumID).update({
      'userId': user!.uid,
      'comments': forum.comments,
      'forumText': forum.forumText,
      'likeList': forum.likeList,
      'imageURL': forum.imageURL,
      'createdAt': forum.createdAt,
      'userImageUrl': user.photoURL,
      'userName': user.displayName,
    });
    notifyListeners();


  }

  Future<void> likeAForum(forumId) async {
    var user = FirebaseAuth.instance.currentUser;
    var forum = _forumsList
        .firstWhere((element) => element.forumId == forumId)
        .likeList;
    if (forum.contains(user!.uid)) {
      forum.remove(user.uid);
    } else {
      forum.add(user.uid);
    }
    await FirebaseFirestore.instance
        .collection("Forums")
        .doc(forumId)
        .update({"likeList": forum});

    notifyListeners();
  }

  List<Comments> getCommentsById(id) {
    return _forumsList.firstWhere((element) => element.forumId == id).comments;
  }

  Future<void> addCommentByForumId(id, Comments obj) async {
    var user = FirebaseAuth.instance.currentUser;
    var comment =
        _forumsList.firstWhere((element) => element.forumId == id).comments;
    comment.add(Comments(
      commentID: "",
      commentUserId: user!.uid,
      commentUserName: user.displayName ?? "",
      commentContent: obj.commentContent,
      commentedAt: obj.commentedAt,
      commentedUserImage: user.photoURL
    ));
    await FirebaseFirestore.instance.collection("Forums").doc(id).collection("comments").add(({
      "commentContent": obj.commentContent,
      "commentUserId":user.uid,
      "commentUserName":user.displayName,
      "commentedAt":Timestamp.now(),
      "commentedUserImageUrl":user.photoURL
      
          
    }));
    notifyListeners();
  }
  List<Forum> getUserForums(){
    var id=FirebaseAuth.instance.currentUser!.uid;
    return _forumsList.where((element) => element.userID==id).toList();
  }
  Future<void> deletForum(id)async{
    FirebaseFirestore.instance.doc("Forums/$id").delete();
    notifyListeners();

  }
  Forum getForumByID(id){
    return _forumsList.firstWhere((element) => element.forumId==id);
  }
}
