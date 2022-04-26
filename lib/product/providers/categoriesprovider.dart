import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamingmob/product/models/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider with ChangeNotifier {
  final List<Categories> _categoryItem = [
   
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

  Future fetchCategories() async {
    final db = FirebaseFirestore.instance.collection("Categories").snapshots();

    final userData = await db.first;
    for (var element in userData.docs) {
      _categoryItem.add(
        Categories(
            id: element.id,
            title: element.data()["title"],
            imageUrl: element.data()["imageUrl"],
            subCategories: element.data()["subCategories"] == null
                ? []
                : getListOfSubCategories(element)),
      );
    }
    
  }

  List<Categories> get categories {
    return _categoryItem;
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
