class Categories{
  String id;
  String title;
  String imageUrl;
  List<SubCategories> subCategories;
  Categories({required this.id, required this.title, required this.imageUrl, required this.subCategories});

}

class SubCategories{
  String id;
  String title;
  String imageUrl;

  SubCategories({required this.id, required this.imageUrl, required this.title});

}