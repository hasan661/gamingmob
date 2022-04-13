import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/widgets/productdetailitem.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/productdetailscreen";

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;
    var productID = ModalRoute.of(context)!.settings.arguments as String;
    var product = Provider.of<ProductProvider>(context, listen: false)
        .filterbyid(productID);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        title: Text(
          product.productName,
        ),
      ),
      body: ProductDetailItem(
        product: product,
        screenWidth: screenWidth,
        id: productID,
      ),
    );
  }
}
