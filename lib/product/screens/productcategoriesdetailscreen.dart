import 'package:flutter/material.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/customsearchdelegate.dart';
import 'package:gamingmob/product/widgets/marketplacebottomappbar.dart';
import 'package:gamingmob/product/widgets/productcategoriesdetailscreenitem.dart';

class ProductCategoriesDetailScreen extends StatefulWidget {
  const ProductCategoriesDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/productcategoriesdetail";

  @override
  State<ProductCategoriesDetailScreen> createState() =>
      _ProductCategoriesDetailScreenState();
}

class _ProductCategoriesDetailScreenState
    extends State<ProductCategoriesDetailScreen> {
  int _selectedIndex = 0;
  selectedtIndexValueAssigner(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final idMap =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String title = idMap["title"] ?? "";
    String id = idMap["id"] ?? "";
    final List<Widget> screens = [
      CategoriesDetailScreenItem(
        id: id,
        title: title,
      ),
      const MyAdScreen(routeFrom: "prod"),
    ];

    return Scaffold(
      floatingActionButton: _selectedIndex == 1
          ? Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddProductScreen.routeName);
                },
                child: const Icon(Icons.add),
              ),
            )
          : null,
      bottomNavigationBar: MarketPlaceBottomAppBar(
        screens: screens,
        selectedIndexValue: selectedtIndexValueAssigner,
        selectedIndex: _selectedIndex,
      ),
      appBar: AppBar(
        title: Text(title),
        actions: [
                  IconButton(onPressed: (){
                    showSearch(context: context, delegate: CustomSearchDelegate());
                  }, icon: const Icon(Icons.search))
                ],
        centerTitle: true,

      ),
      body: screens[_selectedIndex],
    );
  }
}
