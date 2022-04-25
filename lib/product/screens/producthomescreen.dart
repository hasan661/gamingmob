import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:gamingmob/product/widgets/productserach.dart';
import 'package:provider/provider.dart';

class ProductHomeScreen extends StatelessWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/Home";

  @override
  Widget build(BuildContext context) {
    var query = "";
    var gamingProducts = Provider.of<ProductProvider>(context).productItems;
    var rentOnly = Provider.of<ProductProvider>(context).rentOnly();
    var buyOnly = Provider.of<ProductProvider>(context).buyOnly();
    var searchterms = Provider.of<ProductProvider>(context).searchTerms;
    var favoriteItems = Provider.of<ProductProvider>(context).favoritesOnly;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const AppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddProductScreen.routeName);
          },
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 10000,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  // FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.search,
                ))
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
            ProductGrid(
              product: favoriteItems,
            )
          ],
        ),
      ),
    );
  }
}
