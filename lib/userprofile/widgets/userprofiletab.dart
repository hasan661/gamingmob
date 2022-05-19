import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/widgets/myblogsitem.dart';
import 'package:gamingmob/forum/widgets/myforums.dart';
import 'package:gamingmob/product/screens/myadsscreen.dart';


class UserProfileTab extends StatefulWidget {
  const UserProfileTab({Key? key}) : super(key: key);

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          key: const ValueKey("value"),
          height: 40,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white70, Colors.white]),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Text(
                  "Products",
                  style: TextStyle(
                      color: selectedIndex == 0
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Text(
                  "Blogs",
                  style: TextStyle(
                      color: selectedIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Text(
                  "Forums",
                  style: TextStyle(
                      color: selectedIndex == 2
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                ),
              ),
            ],
          ),
        ),
        IndexedStack(
          children: <Widget>[
            Visibility(
              child: const MyAdScreen(routeFrom: "profile"),
              visible: selectedIndex == 0,
            ),
            Visibility(
              child: const MyBlogsScreen(routeFrom: "profile"),
              visible: selectedIndex == 1,
            ),
            Visibility(
              child: const MyForums(routeFrom: "profile"),
              maintainState: true,
              visible: selectedIndex == 2,
            ),
          ],
          index: selectedIndex,
        ),
      ],
    );
  }
}
