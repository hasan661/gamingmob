import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:gamingmob/product/widgets/productserach.dart';
import 'package:provider/provider.dart';

class ProductHomeScreen extends StatelessWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/Home";

  @override
  Widget build(BuildContext context) {
    var mapOfCategoriesAndSubcategories=ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    var title=mapOfCategoriesAndSubcategories["category"] ?? "";
    var subCategory=mapOfCategoriesAndSubcategories["subcategory"]??"";
    var query = "";
    var gamingProducts = Provider.of<ProductProvider>(context).filterByCategory(title, subCategory);
    var rentOnly = Provider.of<ProductProvider>(context).filterRentOnlyByCategory(title, subCategory);
    var buyOnly = Provider.of<ProductProvider>(context).filterBuyOnlyByCategory(title, subCategory);
    var searchterms = Provider.of<ProductProvider>(context).searchTerms;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const AppDrawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(
              0xff8d1ba5,
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.amber,
            unselectedItemColor: Colors.white,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ad_units),
                label: "My Ads",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Account",
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  query: query,
                  context: context,
                  delegate: ProductSearch(searchterms, gamingProducts),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Rent",
              ),
              Tab(
                text: "Buy",
              ),
              
            ],
          ),
          centerTitle: true,
          title: const Text(
            "Gaming Mob",
          ),
        ),
        body: TabBarView(
          children: [
            ProductGrid(
              product: gamingProducts,
            ),
            ProductGrid(
              product: rentOnly,
            ),
            ProductGrid(
              product: buyOnly,
            ),
           
          ],
        ),
      ),
    );
  }
}
