import 'package:flutter/cupertino.dart';
import 'package:gamingmob/product/models/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider with ChangeNotifier {
  List<Categories> _categoryItem = [
    
   
  ];

  getListOfSubCategories(element) {
    List<SubCategories> listOfSubCategories = [];
    element.data()["subCategories"].forEach(
      (e) {
        listOfSubCategories.add(
            SubCategories(id: "1", imageUrl: e["imageUrl"], title: e["title"]));
      },
    );
    return listOfSubCategories;
  }

  Future fetchCategories() async{
    _categoryItem=[];
    var db = FirebaseFirestore.instance.collection("Categories").snapshots();
    final List<Categories> fetchedCategoryItems=[];


    final userData = await db.first;
   
    for (var element in userData.docs) {
      fetchedCategoryItems.add(
        Categories(
            id: element.id,
            title: element.data()["title"],
            imageUrl: element.data()["imageUrl"],
            subCategories: element.data()["subCategories"] == null
                ? []
                : getListOfSubCategories(element)),
      );
    }
    _categoryItem=fetchedCategoryItems;
    
    
  }

  List<Categories> get categories {
    return _categoryItem;
  }

  List<String> get categoriesTitle{
    List<String> categoriesTitle=[];

    for(var element in _categoryItem){
      categoriesTitle.add(element.title);

    }
    return categoriesTitle;
  }
  List<String> subCategories(category){
    List<String> subCat=[];
   Categories cat= _categoryItem.firstWhere((element) => element.title==category);
   for(var element in cat.subCategories){
     subCat.add(element.title);

   }
   return subCat;
    

  }

  Categories filterById(String id) {
    return _categoryItem.firstWhere((element) => element.id == id);
  }

  List<SubCategories> getSubCategories(String id) {
    return _categoryItem.firstWhere((element) {
      return element.id == id;
    }).subCategories;
  }
}
