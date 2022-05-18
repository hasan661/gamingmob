import 'package:flutter/material.dart';
import 'package:gamingmob/forum/widgets/forumbottomappbar.dart';
import 'package:gamingmob/forum/widgets/forumhomeitem.dart';
import 'package:gamingmob/forum/widgets/myforums.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';


class ForumHomeScreen extends StatefulWidget {
  const ForumHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/forumhome";

  @override
  State<ForumHomeScreen> createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen> {
   final List<Widget> screens = [
    const ForumHomeItem(),
    const MyForums()
    
  ];

  var _selectedIndex = 0;

  void selectedIndexValue(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        
        bottomNavigationBar: ForumBottomAppBar(screens: screens, selectedIndex: _selectedIndex, selectedIndexValue: selectedIndexValue),
          appBar: AppBar(
            title: const Text("Forum Home"),
            centerTitle: true,
            
          ),
          drawer: const AppDrawer(),
          body: screens[_selectedIndex]),
    );
  }
}
