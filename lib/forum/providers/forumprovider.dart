import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/forum/models/forum.dart';

class ForumProvider with ChangeNotifier {
  List<Forum> _forumsList = [
    
  ];

  List<Forum> get forums {
    return _forumsList;
  }
  Future<void> fetchForums()async{
   try{
      List<Forum> fetchedForums = [];
      var forumObj = await FirebaseFirestore.instance
          .collection("Forums")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .first;
      var objDocks = forumObj.docs;
      for (var element in objDocks) {
        List<Comments> comments=[];
        List<Likes> likes=[];
        element["comments"].forEach((e){
          comments.add(Comments(commentID: e.commentsId, commentUserId: e.commentUserId, commentUserName: e.commentUserName, commentContent: e.commentContent, commentedAt: e.commentedAt));
        });
        element["likeList"].forEach((e){
          likes.add(Likes(likeID: e.likeID, likeUserId: e.likeUserId, likeUserName: e.likeUserName));
        });
        
        

        fetchedForums.add(
         
         Forum(comments: comments, forumId: element.id, userID: element["userId"], userName: element["userName"], forumText: element["forumText"], likeList: likes, imageURL: element["imageURL"], createdAt: (element["createdAt"] as Timestamp).toDate(), userImageUrl: element["userImageUrl"]=="null"?null:element["userImageUrl"])
        );
         
      }
      print(fetchedForums);
      _forumsList = fetchedForums;
   }
   catch(e){
     print(e.toString()+"hasan");
   }
  }

  Future<void> addForum(Forum forum) async{
    var currentUser=FirebaseAuth.instance.currentUser;
     await FirebaseFirestore.instance.collection("Forums").doc().set({
      'userId':currentUser!.uid,
      'comments':forum.comments,
      'forumText':forum.forumText,
      'likeList':forum.likeList,
      'imageURL':forum.imageURL,
      'createdAt':forum.createdAt,
      'userImageUrl':forum.userImageUrl,
      'userName':currentUser.displayName
    });
    _forumsList.add(Forum(comments: forum.comments, forumId: forum.forumId, userID: currentUser.uid, userName: currentUser.displayName??"", forumText: forum.forumText, likeList: forum.likeList, imageURL: forum.imageURL, createdAt: forum.createdAt, userImageUrl: currentUser.photoURL));
    notifyListeners();
  }
}
