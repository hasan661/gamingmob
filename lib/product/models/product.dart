

class Product {
  final String productID;
  final String userID;
  final String productType;
  final String productName;
  final List<String> imageURL;
  final int productPrice;
  final String productDescripton;
  bool isFavorite;
  final String ownerMobileNum;
  final String productCategory;
  final String productSubCategory;
  final String ownerName; 
  final String ownerEmail;
  final String? ownerImage;

  Product({
    required this.imageURL,
    this.isFavorite = false,
    required this.productDescripton,
    required this.productID,
    required this.productName,
    this.productPrice = 0,
    required this.productType,
    required this.userID,
    required this.ownerMobileNum,
    required this.productCategory,
    required this.productSubCategory,
    required this.ownerName,
    required this.ownerEmail,
    this.ownerImage
  });
}
