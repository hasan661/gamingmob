

class Product {
  final String productID;
  final String userID;
  final String productType;
  final String productName;
  final List<String> imageURL;
  final int productPrice;
  final String productDescripton;
  bool isFavorite;
  final int productRentFee;
  final String ownerMobileNum;

  Product({
    required this.imageURL,
    this.isFavorite = false,
    required this.productDescripton,
    required this.productID,
    required this.productName,
    this.productPrice = 0,
    required this.productType,
    required this.userID,
    this.productRentFee = 0,
    required this.ownerMobileNum,
  });
}
