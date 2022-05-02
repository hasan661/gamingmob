import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String id;
  final String title;
  final String imageURL;
  final String blogContent;
  final Timestamp blogCreationDate;

  const Blog({
    required this.id,
    required this.blogContent,
    required this.imageURL,
    required this.title,
    required this.blogCreationDate,
  });
}
