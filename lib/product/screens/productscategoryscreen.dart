import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
import 'package:gamingmob/product/widgets/categoriesscreenitem.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:gamingmob/product/widgets/productserach.dart';
import 'package:provider/provider.dart';

class ProductCategoriesScreen extends StatelessWidget {
  const ProductCategoriesScreen({Key? key}) : super(key: key);
  static const routeName = "/productcategories";
  @override
  Widget build(BuildContext context) {
    var searchterms = Provider.of<ProductProvider>(context).searchTerms;

    var gamingProducts = Provider.of<ProductProvider>(context).getAllProductItems;
    var favoritesProducts=Provider.of<ProductProvider>(context).favoritesOnly;
    var categires =
        Provider.of<CategoryProvider>(context, listen: false).categories;
    var query = "";
    return DefaultTabController(
      length: 2,
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
                ))
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "Categories",
              ),
              Tab(
                text: "Favorites",
              ),
             
              
            ],
          ),
          centerTitle: true,
          title: const Text(
            "Gaming Mob",
          ),
        ),
        body: TabBarView(children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: categires.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              return CategoriesScreenItem(index: index);
            },
          ),
        ),
        ProductGrid(product: favoritesProducts)

        ])
      ),
    );
  }
}
