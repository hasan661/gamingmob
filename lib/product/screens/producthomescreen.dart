import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/customsearchdelegate.dart';
import 'package:gamingmob/product/widgets/marketplacebottomappbar.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:provider/provider.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/Home";

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  var _selectedIndex = 0;

  void selectedIndexValue(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mapOfCategoriesAndSubcategories =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var title = mapOfCategoriesAndSubcategories["category"] ?? "";
    var subCategory = mapOfCategoriesAndSubcategories["subcategory"] ?? "";

    List<Widget> screens = [
      FutureBuilder(
          future: Provider.of<ProductProvider>(context).fetchProducts(),
          builder: (context, snapshot) {
            var gamingProducts = Provider.of<ProductProvider>(context)
                .filterByCategory(title, subCategory);
            var rentOnly = Provider.of<ProductProvider>(context)
                .filterRentOnlyByCategory(title, subCategory);
            var buyOnly = Provider.of<ProductProvider>(context)
                .filterBuyOnlyByCategory(title, subCategory);
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserProducts")
                    .snapshots(),
                builder: (context, snapshot) {
                  return TabBarView(
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
                  );
                });
          }),
      const MyAdScreen(routeFrom: "prod"),
    ];
    return DefaultTabController(
      length: 3,
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
          bottomNavigationBar: MarketPlaceBottomAppBar(
              screens: screens,
              selectedIndexValue: selectedIndexValue,
              selectedIndex: _selectedIndex),
          appBar: AppBar(
            bottom: _selectedIndex == 0
                ? const TabBar(
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
                  )
                : null,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                  icon: const Icon(Icons.search))
            ],
            centerTitle: true,
            title: Text(
              subCategory == "" ? title : subCategory,
            ),
          ),
          body: screens[_selectedIndex]),
    );
  }
}
