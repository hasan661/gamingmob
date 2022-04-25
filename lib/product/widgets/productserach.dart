import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/widgets/producthomeitem.dart';

class ProductSearch extends SearchDelegate {
  List<String> searchTerms;
  List<Product> gamingproducts;
  ProductSearch(this.searchTerms, this.gamingproducts);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var i in searchTerms) {
      if (i.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(i);
      }
    }
    return GridView.builder(
      shrinkWrap: true,
      itemCount: matchQuery.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 8,
        mainAxisExtent: 260,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 2,
      ),
      itemBuilder: (ctx, index) => ProductHomeItem(
        gamingProducts: gamingproducts
            .where((element) => element.productName == matchQuery[index])
            .toList(),
        index: index,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var i in searchTerms) {
      if (i.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(i);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                query = matchQuery[index];
              },
              title: Text(matchQuery[index]),
            ));
  }
}