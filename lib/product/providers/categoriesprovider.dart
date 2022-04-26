import 'package:flutter/cupertino.dart';
import 'package:gamingmob/product/models/categories.dart';

class CategoryProvider with ChangeNotifier {
  final List<Categories> _categoryItem = [
    Categories(
      id: "1",
      title: "Headsets",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [],
    ),
    Categories(
      id: "2",
      title: "Gaming CDs",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [
        SubCategories(
          id: "1",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "XBOX One",
        ),
        SubCategories(
          id: "2",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "XBOX 360",
        ),
        SubCategories(
          id: "3",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "PS3",
        ),
        SubCategories(
          id: "4",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "PS4",
        ),
        SubCategories(
          id: "5",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "PS5",
        ),
        SubCategories(
          id: "6",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "XBOX Series X|S",
        ),
        SubCategories(
          id: "7",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "PC",
        ),
         SubCategories(
          id: "8",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
          title: "All",
        ),
      ],
    ),
    Categories(
      id: "3",
      title: "Gaming Chairs",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [],
    ),
    Categories(
      id: "4",
      title: "PC Accesories",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [],
    ),
    Categories(
      id: "5",
      title: "Consoles and Controllers",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [],
    ),
    Categories(
      id: "6",
      title: "Others",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
      subCategories: [],
    )
  ];
  List<Categories> get categories {
    return _categoryItem;
  }

  Categories filterById(String id) {
    return _categoryItem.firstWhere((element) => element.id == id);
  }
  List<SubCategories> getSubCategories(String id){
    return _categoryItem.firstWhere((element) {
      return
      element.id==id;
    }).subCategories;

  }
}
