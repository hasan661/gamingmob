import 'package:flutter/cupertino.dart';
import 'package:gamingmob/forum/models/forum.dart';

class ForumProvider with ChangeNotifier {
  final List<Forum> _forumsList = [
    Forum(
      likeList: [],
      comments: [
        Comments(
          commentID: "1",
          commentUserId: "2",
          commentUserName: "Hasan",
          commentContent: "Why are you like that thomas",
          commentedAt: DateTime.now(),
        )
      ],
      forumId: "1",
      userID: "1",
      userName: "Thommas Shelby",
      forumText: "I will continue till I find a man whom I cannot defeat",
      imageURL:
          "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FConsoles%20And%20Controllers.jpg?alt=media&token=fb1eafb5-70a4-4087-a919-6e7f5467dcb6",
      createdAt: DateTime.now(),
      userImageUrl: "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2Fdownload%20(2).jpg?alt=media&token=304f1edb-23d4-45b1-9fce-f224128c8a1a"
    ),
    Forum(
      likeList: [],
      comments: [
       
      ],
      forumId: "1",
      userID: "1",
      userName: "Thommas Shelby",
      forumText: "I will continue till I find a man whom I cannot defeat",
      imageURL:
          "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FConsoles%20And%20Controllers.jpg?alt=media&token=fb1eafb5-70a4-4087-a919-6e7f5467dcb6",
      createdAt: DateTime.now(),
      userImageUrl: null
    ),
  ];

  List<Forum> get forums {
    return _forumsList;
  }

  Future<void> addForum(Forum forum) async{
    _forumsList.add(Forum(comments: forum.comments, forumId: forum.forumId, userID: forum.userID, userName: forum.userName, forumText: forum.forumText, likeList: forum.likeList, imageURL: forum.imageURL, createdAt: forum.createdAt, userImageUrl: forum.userImageUrl));
    notifyListeners();
  }
}
