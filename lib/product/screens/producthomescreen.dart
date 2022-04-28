import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/accounts.dart';
import 'package:gamingmob/product/screens/chatscreen.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:gamingmob/product/widgets/productserach.dart';
import 'package:provider/provider.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/Home";

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  var _selectedIndex=0;
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
      const ChatScreen(),
      const MyAdScreen(),
      const AccountScreen()
    ];
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
              
              onTap: (index)=>{
                setState((){
                  _selectedIndex=index;
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
          bottom: _selectedIndex==0? const TabBar(
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
