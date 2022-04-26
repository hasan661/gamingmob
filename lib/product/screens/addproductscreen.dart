import 'package:flutter/material.dart';
import 'package:gamingmob/product/widgets/addproductscreenitem.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const routeName = "/addproduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Your Products"),
        centerTitle: true,
      ),
      body: const AddProductScreenItem(),
    );
  }
}
