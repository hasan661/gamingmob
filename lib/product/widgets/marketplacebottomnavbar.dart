import 'package:flutter/material.dart';
class BottomNavBarMarketplace extends StatefulWidget {
  const BottomNavBarMarketplace({ Key? key }) : super(key: key);

  @override
  State<BottomNavBarMarketplace> createState() => _BottomNavBarMarketplaceState();
}

class _BottomNavBarMarketplaceState extends State<BottomNavBarMarketplace> {
  var _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Theme(
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
          );
  }
}