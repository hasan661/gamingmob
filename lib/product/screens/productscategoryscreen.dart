import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
import 'package:gamingmob/product/widgets/customsearchdelegate.dart';
import 'package:gamingmob/product/widgets/marketplacebottomappbar.dart';
import 'package:gamingmob/product/widgets/productcategoriesscreenitem.dart';
import 'package:provider/provider.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({Key? key}) : super(key: key);
  static const routeName = "/productcategories";

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  var _selectedIndex = 0;

  void selectedIndexValue(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  List<Widget> screens = [
    const CategoriesScreenItem(),
    const MyAdScreen(routeFrom: "prod"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: _selectedIndex == 1
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddProductScreen.routeName);
                    },
                    child: const Icon(Icons.add),
                  ),
                )
              : null,
          drawer: const AppDrawer(),
          bottomNavigationBar: MarketPlaceBottomAppBar(
              screens: screens,
              selectedIndexValue: selectedIndexValue,
              selectedIndex: _selectedIndex),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
            bottom: _selectedIndex == 0
                ? const TabBar(
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Categories",
                      ),
                      Tab(
                        text: "Favorites",
                      ),
                    ],
                  )
                : null,
            centerTitle: true,
            title: const Text(
              "Gaming Mob",
            ),
          ),
          body: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return screens[_selectedIndex];
              })),
    );
  }
}
