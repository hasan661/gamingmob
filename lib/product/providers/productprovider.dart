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
      ownerMobileNum: "03452226620"
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
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://gmedia.playstation.com/is/image/SIEPDC/ps4-pro-console-01-en-26oct18?\$1600px--t\$",
       
      ],
      productDescripton: "New PS4 Console which is great for having fun",
      productID: "P3",
      productName: "PS4 Console",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P4",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
        "https://media.direct.playstation.com/is/image/psdglobal/dualsense-ps5-controller-white-accessory-front?\$Background_Large\$"
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P5",
      productName: "PS5",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P6",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
        "https://media.direct.playstation.com/is/image/psdglobal/dualsense-ps5-controller-white-accessory-front?\$Background_Large\$"
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P7",
      productName: "PS5",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P8",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
        "https://media.direct.playstation.com/is/image/psdglobal/dualsense-ps5-controller-white-accessory-front?\$Background_Large\$"
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P9",
      productName: "PS5",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P10",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
        "https://media.direct.playstation.com/is/image/psdglobal/dualsense-ps5-controller-white-accessory-front?\$Background_Large\$"
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P11",
      productName: "PS5",
      productPrice: 100000,
      productType: "Sell",
      userID: "U1",
      ownerMobileNum: "03452226620"
    ),
    Product(
      imageURL: [
        "https://www.shophive.com/media/catalog/product/cache/3617b85921733ef3774cdbec091e1c0f/6/1/619bkvkw35l._sl1500_.jpg",
      ],
      productDescripton: "New PS5 which is great for having fun",
      productID: "P12",
      productName: "PS5",
      productType: "Rent",
      userID: "U1",
      productRentFee: 1000,
      ownerMobileNum: "03452226620"
    ),
  ];

  List<Product> get productItems {
    return _productItems;
  }

  List<Product> rentOnly() {
    return _productItems
        .where((element) => element.productType == "Rent")
        .toList();
  }

  List<Product> buyOnly() {
    return _productItems
        .where((element) => element.productType == "Sell")
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