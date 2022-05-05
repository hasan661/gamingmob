import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  List<Product> _productItems = [];

  Future<void> fetchProducts() async {
    _productItems = [];
    List<Product> _products = [];
    var obj = await db.collection("UserProducts").snapshots().first;
    var objDocks = obj.docs;
    List<String> imageUrls = [];

    for (var element in objDocks) {
      for (var e in element["imageURL"]) {
        imageUrls.add(e.toString());
      }
      
      _products.add(Product(
        ownerName: element["ownerName"],
        imageURL: imageUrls,
        productDescripton: element["productDescripton"],
        productID: element.id,
        productName: element["productName"],
        productType: element["productType"],
        userID: element["userID"],
        ownerMobileNum: element["ownerMobileNum"],
        productCategory: element["productCategory"],
        productSubCategory: element["productSubCategory"],
        productPrice: element["productPrice"],
        isFavorite: element["isFavorite"],
      ));
    }
    _productItems = _products;
  }

  List<Product> get getAllProductItems {
    return _productItems;
  }

  List<Product> get userProducts {
    var id = auth.currentUser!.uid;
    return _productItems.where((element) => element.userID == id).toList();
  }

  List<Product> filterByCategory(String category, String subCategory) {
    if (subCategory == "All") {
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
    var p = _productItems
        .where((element) =>
            element.productType == "Rent" &&
            element.productCategory == category &&
            element.productSubCategory == subCategory)
        .toList();
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

  Future<void> updateProduct(Product newProduct) async {
    db.collection("UserProducts").doc(newProduct.productID).update({
      "imageURL": newProduct.imageURL,
      "productDescripton": newProduct.productDescripton,
      "productName": newProduct.productName,
      "productPrice": newProduct.productPrice,
      "productType": newProduct.productType,
      "userID": newProduct.userID,
      "ownerMobileNum": newProduct.ownerMobileNum,
      "productCategory": newProduct.productCategory,
      "productSubCategory": newProduct.productSubCategory,
      "isFavorite": false,
    });
    notifyListeners();
  }

  Future<void> addproduct(Product newProduct) async {
    // var firestoreObject = FirebaseFirestore.instance;
    await db.collection("UserProducts").doc().set({
      "imageURL": newProduct.imageURL,
      "productDescripton": newProduct.productDescripton,
      "productName": newProduct.productName,
      "productPrice": newProduct.productPrice,
      "productType": newProduct.productType,
      "userID": newProduct.userID,
      "ownerMobileNum": newProduct.ownerMobileNum,
      "productCategory": newProduct.productCategory,
      "productSubCategory": newProduct.productSubCategory,
      "isFavorite": false,
      "ownerName":auth.currentUser!.displayName
    });

    _productItems.add(newProduct);

    notifyListeners();
  }

  List<Product> get favoritesOnly {
    return _productItems
        .where((element) => element.isFavorite == true)
        .toList();
  }

  Future<void> deleteProduct(String id) async {
    await db.doc("UserProducts/$id").delete();
    _productItems.removeWhere((element) => element.productID == id);
    notifyListeners();
  }
}
