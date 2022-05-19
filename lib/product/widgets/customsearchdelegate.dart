import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate{
  List<Product> searchTerms=[];
  
  @override
  List<Widget>? buildActions(BuildContext context) {
  //  searchTerms= Provider.of<ProductProvider>(context).All;
    return[
      IconButton(onPressed: (){
        query='';

      }, icon: const Icon(Icons.clear))
    ];
   
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  
  }

  @override
  Widget buildResults(BuildContext context) {
    searchTerms= Provider.of<ProductProvider>(context).all;
    List<Product> matchQuery=[];
    for (var items in searchTerms){
      if(items.productName.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(items);
      }

    }
    return ProductGrid(product: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}