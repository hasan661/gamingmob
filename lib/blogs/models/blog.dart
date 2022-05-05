import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String id;
  final String title;
  final String imageURL;
  final BlogContent blogContent;
  final Timestamp blogCreationDate;
  final String userId;
  final String userName;

  const Blog({
    required this.id,
    required this.blogContent,
    required this.imageURL,
    required this.title,
    required this.blogCreationDate,
    required this.userId,
    required this.userName,
  });
}
 
 class BlogContent{
   List content;
   BlogContent(this.content);

 }