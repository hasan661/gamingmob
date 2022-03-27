import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/widgets/producthomeitem.dart';
import 'package:provider/provider.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/Home";
  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  var query="";
  Widget productgrid(product) {
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

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).primaryColor;
    var gamingProducts = Provider.of<ProductProvider>(context).productItems;
    var rentOnly = Provider.of<ProductProvider>(context).rentOnly();
    var buyOnly = Provider.of<ProductProvider>(context).buyOnly();
    var searchterms = Provider.of<ProductProvider>(context).searchTerms;
    var favoriteItems = Provider.of<ProductProvider>(context).favoritesOnly;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddProductScreen.routeName);
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.red,
          ),
          elevation: 10000,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: backgroundColor,
          child: SizedBox(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: backgroundColor,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.chat,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Chat",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: backgroundColor,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.ad_units,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "My Ads",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    query: query,
                    context: context,
                    delegate: CustomSearchDelegate(searchterms, gamingProducts),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ))
          ],
          bottom: const TabBar(labelColor: Colors.white, tabs: [
            Tab(
              text: "All",
            ),
            Tab(
              text: "Rent Only",
            ),
            Tab(
              text: "Buy Only",
            ),
            Tab(
              text: "Favorites Only",
            ),
          ]),
          centerTitle: true,
          title: const Text(
            "Gaming Mob",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: TabBarView(
          children: [
            productgrid(gamingProducts),
            productgrid(rentOnly),
            productgrid(buyOnly),
            productgrid(favoriteItems)
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms;
  List<Product> gamingproducts;
  CustomSearchDelegate(this.searchTerms, this.gamingproducts);
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
          onTap: (){
            
            query=matchQuery[index];

          },
              title: Text(matchQuery[index]),
            ));
  }
}
