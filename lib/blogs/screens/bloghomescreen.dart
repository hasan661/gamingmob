import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/screens/addblogsscreen.dart';
import 'package:gamingmob/blogs/widgets/myblogsitem.dart';
import 'package:gamingmob/blogs/widgets/bloghomeitem.dart';
import 'package:gamingmob/blogs/widgets/blogsbottomappbar.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';

class BlogHomeScreen extends StatefulWidget {
  const BlogHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/blog-home";

  @override
  State<BlogHomeScreen> createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  final List<Widget> screens = [
    const BlogHomeItem(),
    const MyBlogsScreen(routeFrom: "blog"),
  ];
  var _selectedIndex = 0;

  void selectedIndexValue(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _selectedIndex==1? TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddBlogScreen.routeName);
              },
              child: const Text(
                "Write A Blog",
                style: TextStyle(color: Colors.white),
              )):Container()
        ],
        title: const Text("Blogs"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: screens[_selectedIndex],
      bottomNavigationBar: BlogsBottomAppBar(
        screens: screens,
        selectedIndex: _selectedIndex,
        selectedIndexValue: selectedIndexValue,
      ),
    );
  }
}
