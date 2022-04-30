import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/accounts.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/chatscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
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
  

  List<Widget> screens = [
    const CategoriesScreenItem(),
    const ChatScreen(),
    const MyAdScreen(),
    const AccountScreen()
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
