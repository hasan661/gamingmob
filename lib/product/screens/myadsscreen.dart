import 'package:flutter/material.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';

class MyAdScreen extends StatelessWidget {
  const MyAdScreen({Key? key}) : super(key: key);
  static const routeName = "/MyAds";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(onPressed: (){
            Navigator.of(context).pushNamed(AddProductScreen.routeName);
          },child: const Icon(Icons.add),),
        )
      ],
    );
  }
}
