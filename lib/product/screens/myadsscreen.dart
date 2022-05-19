import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:provider/provider.dart';

class MyAdScreen extends StatelessWidget {
  const MyAdScreen({Key? key}) : super(key: key);
  static const routeName = "/MyAds";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var productObj = Provider.of<ProductProvider>(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("UserProducts").snapshots(),
      builder: (context,snapshot) {
        return FutureBuilder(
            future: Provider.of<ProductProvider>(context).fetchProducts(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var userProducts = productObj.userProducts;
                if(userProducts.isEmpty){
                  return const Center(child: Text("No Products Yet", style: TextStyle(color: Colors.black),),);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userProducts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: userProducts[index].imageURL.isEmpty
                                ? null
                                : NetworkImage(
                                    userProducts[index].imageURL[0],
                                  ),
                          ),
                          title: Text(userProducts[index].productName),
                          trailing: SizedBox(
                            width: width * 0.24,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
    
                                    productObj.deleteProduct(
                                        userProducts[index].productID);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(AddProductScreen.routeName, arguments: userProducts[index].productID);
                                  },
                                  icon: const Icon(Icons.edit),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            });
      }
    );
  }
}
