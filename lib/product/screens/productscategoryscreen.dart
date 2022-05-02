import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/accounts.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/chatscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }
  var _selectedIndex = 0;

  void selectedIndexValue(value){
    setState(() {
      _selectedIndex=value;
    });
  }
  

  List<Widget> screens = [
    const CategoriesScreenItem(),
    const MyAdScreen(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       floatingActionButton: _selectedIndex==2? Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            elevation: 0,
          onPressed: () {
            Navigator.of(context).pushNamed(AddProductScreen.routeName);
          },
          child: const Icon(Icons.add),
              ),
        ):null,
        
        drawer: const AppDrawer(),
        bottomNavigationBar: MarketPlaceBottomAppBar(screens: screens, selectedIndexValue: selectedIndexValue, selectedIndex: _selectedIndex),
        
        appBar: AppBar(
         
          bottom: _selectedIndex==0? const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "Categories",
              ),
              Tab(
                text: "Favorites",
              ),
            ],
          ):null,
          centerTitle: true,
          title: const Text(
            "Gaming Mob",
          ),
        ),
        body: screens[_selectedIndex]
      ),
    );
  }
}
