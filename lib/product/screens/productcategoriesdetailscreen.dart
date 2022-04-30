import 'package:flutter/material.dart';

import 'package:gamingmob/product/screens/accounts.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/chatscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
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
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var idMap =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String title = idMap["title"] ?? "";
    String id = idMap["id"] ?? "";
    List<Widget> screens = [
      CategoriesDetailScreenItem(
        id: id,
        title: title,
      ),
      const ChatScreen(),
      const MyAdScreen(),
      const AccountScreen()
    ];

    return Scaffold(
      floatingActionButton: _selectedIndex == 2
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(
            0xff8d1ba5,
          ),
        ),
        child: BottomNavigationBar(
          onTap: (index) => {
            setState(() {
              _selectedIndex = index;
            })
          },
          iconSize: 30,
          selectedFontSize: 15,
          fixedColor: Colors.amber,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
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
      appBar: AppBar(),
      body: screens[_selectedIndex],
    );
  }
}
