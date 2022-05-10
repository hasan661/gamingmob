class Blog {
  final String id;
  final String title;
  final String imageURL;
  final List<BlogContent> blogContent;
  final DateTime blogCreationDate;
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
   final String type;
   dynamic data;
   BlogContent({required this.data, required this.type});

 }