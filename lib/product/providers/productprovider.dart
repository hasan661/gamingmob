import 'dart:math';

import 'package:gamingmob/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _productItems = [
    Product(
      
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
        "https://media.direct.playstation.com/is/image/psdglobal/dualsense-ps5-controller-white-accessory-front?\$Background_Large\$"
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P1",
      productName: "PS5",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620",
      productCategory: "Consoles and Controllers",
      productSubCategory: "",
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P2",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620",
      productCategory: "Consoles and Controllers",
      productSubCategory: "",
    ),
     Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P3",
      productName: "XBOX One",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620",
      productCategory: "Gaming CDs",
      productSubCategory: "XBOX One",
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P4",
      productName: "Headset",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620",
      productCategory: "Headsets",
      productSubCategory: "",
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P5",
      productName: "Headset1",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620",
      productCategory: "Gaming CDs",
      productSubCategory: "PS3",
    ),
  ];

  List<Product> get getAllProductItems {
    return _productItems;
  }

  List<Product> filterByCategory(String category, String subCategory){
    if(subCategory=="All"){
      return _productItems.where((element) => element.productCategory==category).toList();
    }

    return _productItems.where((element) => element.productCategory==category && element.productSubCategory==subCategory).toList();

  }
  List<Product> filterRentOnlyByCategory(String category, String subCategory) {
    return _productItems
        .where((element) => element.productType == "Rent" && element.productCategory==category && element.productSubCategory==subCategory)
        .toList();
  }

  List<Product> filterBuyOnlyByCategory(String category, String subCategory) {
    return _productItems
        .where((element) => element.productType == "Sell" && element.productCategory==category && element.productSubCategory==subCategory)
        .toList();
  }

  Product filterbyid(String id) {
    var productIndex =
        _productItems.indexWhere((element) => element.productID == id);
    return _productItems[productIndex];
  }

  void toggleFavorites(String id){
    var _indexToToggle=_productItems.indexWhere((element) => element.productID==id);
    _productItems[_indexToToggle].isFavorite=!_productItems[_indexToToggle].isFavorite;
    notifyListeners();
  }

  List<String> get searchTerms{
    List<String> itemnames=[];
    for (var element in _productItems) {
      itemnames.add(element.productName);
    }
    return itemnames;

  }

  void addproduct(Product newProduct){
  

    _productItems.add(newProduct);
   
    notifyListeners();

  }
  List<Product> get favoritesOnly{
    return _productItems.where((element) => element.isFavorite==true).toList();

  }
}