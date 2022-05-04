import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
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

  void selectedIndexValue(value){
    setState(() {
      _selectedIndex=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    var mapOfCategoriesAndSubcategories =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var title = mapOfCategoriesAndSubcategories["category"] ?? "";
    var subCategory = mapOfCategoriesAndSubcategories["subcategory"] ?? "";

    var gamingProducts = Provider.of<ProductProvider>(context)
        .filterByCategory(title, subCategory);
    var rentOnly = Provider.of<ProductProvider>(context)
        .filterRentOnlyByCategory(title, subCategory);
    var buyOnly = Provider.of<ProductProvider>(context)
        .filterBuyOnlyByCategory(title, subCategory);
    List<Widget> screens = [
      TabBarView(
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
      
      const MyAdScreen(),
      
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
          drawer: const AppDrawer(),
          bottomNavigationBar: MarketPlaceBottomAppBar(screens: screens, selectedIndexValue: selectedIndexValue, selectedIndex: _selectedIndex),
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
            centerTitle: true,
            title: const Text(
              "Gaming Mob",
            ),
          ),
          body: screens[_selectedIndex]),
    );
  }
}
