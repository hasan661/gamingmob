import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  List<Product> _productItems = [];
  var page = 14;

  Future<void> fetchProducts() async {
    try {
      var currentUser = auth.currentUser;

      List<Product> _products = [];
      var obj = await db.collection("UserProducts").snapshots().first;
      var objDocks = obj.docs;

      List<String> imageUrls = [];

      for (var element in objDocks) {
        for (var e in element["imageURL"]) {
          imageUrls.add(e.toString());
        }
        var isFavoriteObj = await db
            .collection("UserProductFavorites")
            .doc(currentUser!.uid + element.id)
            .get();

        try {
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
              ownerEmail: element["ownerEmail"],
              isFavorite: isFavoriteObj["isFavorite"] ?? false,
              ownerImage: element["ownerImage"]));
        } catch (e) {
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
              ownerEmail: element["ownerEmail"],
              isFavorite: false,
              ownerImage: element["ownerImage"]));
        }
        imageUrls = [];
      }
      _productItems = _products;
    } catch (e) {
      rethrow;
    }
    // notifyListeners();
  }

  List<Product> get all {
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
        .where(
          (element) =>
              element.productCategory == category &&
              element.productSubCategory == subCategory,
        )
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

  Future<void> toggleFavorites(String id) async {
    var currentUser = auth.currentUser;
    var obj = await db
        .collection("UserProductFavorites")
        .doc(currentUser!.uid + id)
        .get();
    if (obj.data() == null) {
      await db
          .collection("UserProductFavorites")
          .doc(currentUser.uid + id)
          .set({
        "isFavorite": true,
      });
    } else {
      await db
          .collection("UserProductFavorites")
          .doc(currentUser.uid + id)
          .update({'isFavorite': !obj["isFavorite"]});
    }

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
      "ownerEmail": newProduct.ownerEmail,
      "ownerImage": auth.currentUser!.photoURL ?? ""
    });

    notifyListeners();
  }

  Future<void> addproduct(Product newProduct) async {
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
      "ownerName": auth.currentUser!.displayName,
      "ownerEmail": auth.currentUser!.email,
      "ownerImage": auth.currentUser!.photoURL ?? ""
    });

    // _productItems.add(Product(imageURL: newProduct.imageURL, productDescripton: newProduct.productDescripton, productID: newProduct.productID, productName: newProduct.productName, productType: newProduct.productType, userID: auth.currentUser!.uid, ownerMobileNum: auth.currentUser!.phoneNumber??"", productCategory: newProduct.productCategory, productSubCategory: newProduct.productSubCategory, ownerName: auth.currentUser!.displayName??"", ownerEmail: auth.currentUser!.email??""));

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
