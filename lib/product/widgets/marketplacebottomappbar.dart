import 'package:flutter/material.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';

class MarketPlaceBottomAppBar extends StatefulWidget {
  const MarketPlaceBottomAppBar(
      {Key? key,
      required this.screens,
      required this.selectedIndexValue,
      required this.selectedIndex})
      : super(key: key);
  final List<Widget> screens;
  final void Function(int) selectedIndexValue;
  final int selectedIndex;

  @override
  State<MarketPlaceBottomAppBar> createState() =>
      _MarketPlaceBottomAppBarState();
}

class _MarketPlaceBottomAppBarState extends State<MarketPlaceBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(
          0xff8d1ba5,
        ),
      ),
      child: BottomNavigationBar(
        onTap: (index) => {
          if(index==0 && index==widget.selectedIndex){
            Navigator.of(context).pushReplacementNamed(ProductCategoriesScreen.routeName)
            

          }
          else{
            widget.selectedIndexValue(index),
          }
          
        },
        iconSize: 30,
        selectedFontSize: 15,
        fixedColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: widget.selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units),
            label: "My Products",
          ),
          
        ],
      ),
    );
  }
}
