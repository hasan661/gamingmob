class Forum {
  final String forumId;
  final String userName;
  final String userID;
  final List<Comments> comments;
  final String forumText;
  final List<String> likeList;
  String? imageURL;
  final DateTime createdAt;
  String? userImageUrl;

  Forum({
    required this.comments,
    required this.forumId,
    required this.userID,
    required this.userName,
    required this.forumText,
    required this.likeList,
    required this.imageURL,
    required this.createdAt,
    required this.userImageUrl,
    
  });
}

class Comments {
  final String commentID;
  final String commentUserName;
  final String commentUserId;
  final String commentContent;
  final DateTime commentedAt;
  List<String> isLiked=[];
  List<Comments> comments=[];
  Comments({
    required this.commentID,
    required this.commentUserId,
    required this.commentUserName,
    required this.commentContent,
    required this.commentedAt,
    
    
  });
}

