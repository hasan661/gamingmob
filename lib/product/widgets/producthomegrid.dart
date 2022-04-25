import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/widgets/producthomeitem.dart';
class ProductGrid extends StatelessWidget {
  final List<Product> product;
  const ProductGrid({ Key? key,required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: product.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 260,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 2,
      ),
      itemBuilder: (ctx, index) => ProductHomeItem(
        gamingProducts: product,
        index: index,
      ),
    );
  }
}