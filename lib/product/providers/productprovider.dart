import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _productItems = [
    
  ];

  Future<void> fetchProducts()async{
    _productItems=[];
   List<Product> _products=[];
    var obj=await FirebaseFirestore.instance.collection("UserProducts").snapshots().first;
    
    var objDocks=obj.docs;
    
    for(var element in objDocks){
      print(element.id);
      List<String> imageUrls=[];
      for(var e in element["imageURL"]){
        imageUrls.add(e.toString());

      }
      _products.add(Product(imageURL: imageUrls, productDescripton: element["productDescripton"], productID: element.id, productName: element["productName"], productType: element["productType"], userID: element["userID"], ownerMobileNum: element["ownerMobileNum"], productCategory: element["productCategory"], productSubCategory: element["productSubCategory"],productPrice: element["productPrice"],isFavorite: element["isFavorite"],));


    }
    _productItems=_products;
    print("object");
    print(_products.toString()+"hasan");
    notifyListeners();
  }

  List<Product> get getAllProductItems {
    return _productItems;
  }

  List<Product> filterByCategory(String category, String subCategory) {
    if (subCategory == "All") {
      print(_productItems
          .where((element) => element.productCategory == category)
          .toList());
      return _productItems
          .where((element) => element.productCategory == category)
          .toList();
    
    }

    return _productItems
        .where((element) =>
            element.productCategory == category &&
            element.productSubCategory == subCategory)
        .toList();
  }

  List<Product> filterRentOnlyByCategory(String category, String subCategory) {
    var p=_productItems
    
        .where((element) =>
            element.productType == "Rent" &&
            element.productCategory == category &&
            element.productSubCategory == subCategory)
        .toList();
    print(category);
    print(subCategory);
    return p;
  }

  List<Product> filterBuyOnlyByCategory(String category, String subCategory) {
    return _productItems
        .where((element) =>
            element.productType == "Sell" &&
            element.productCategory == category &&
            element.productSubCategory == subCategory)
        .toList();
  }

  Product filterbyid(String id) {
    var productIndex =
        _productItems.indexWhere((element) => element.productID == id);
    return _productItems[productIndex];
  }

  void toggleFavorites(String id) {
    var _indexToToggle =
        _productItems.indexWhere((element) => element.productID == id);
    _productItems[_indexToToggle].isFavorite =
        !_productItems[_indexToToggle].isFavorite;
    notifyListeners();
  }

  void addproduct(Product newProduct) {
    _productItems.add(newProduct);
    var firestoreObject = FirebaseFirestore.instance;
    var authId = FirebaseAuth.instance.currentUser!.uid;
    firestoreObject.collection("UserProducts").doc().set({
      "imageURL": newProduct.imageURL,
      "productDescripton": newProduct.productDescripton,
      "productName": newProduct.productName,
      "productPrice": newProduct.productPrice,
      "productType": newProduct.productType,
      "userID": newProduct.userID,
      "ownerMobileNum": newProduct.ownerMobileNum,
      "productCategory": newProduct.productCategory,
      "productSubCategory": newProduct.productSubCategory,
      "isFavorite":false,
    });
    
    notifyListeners();
  }

  List<Product> get favoritesOnly {
    return _productItems
        .where((element) => element.isFavorite == true)
        .toList();
  }
}
