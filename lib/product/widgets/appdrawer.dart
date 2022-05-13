import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/blogs/screens/bloghomescreen.dart';
import 'package:gamingmob/eventmanagement/screens/eventhomescreen.dart';
import 'package:gamingmob/forum/screens/forumhomescreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple,
      child: ListView(
        children: [
          AppBar(
            title: const Text("Hello Friend"),
            automaticallyImplyLeading: false,
            // backgroundColor: ,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductCategoriesScreen.routeName);
            },
            leading: const Icon(
              Icons.shop,
              color: Colors.white,
            ),
            title: const Text("Marketplace",
                style: TextStyle(color: Colors.white)),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(BlogHomeScreen.routeName);
            },
            leading: const Icon(
              Icons.notes,
              color: Colors.white,
            ),
            title: const Text("Blog", style: TextStyle(color: Colors.white)),
          ),
          const Divider(),
          ListTile(
            onTap: (){
               Navigator.of(context)
                  .pushReplacementNamed(ForumHomeScreen.routeName);
              
            },
            leading:const Icon(
              Icons.chat,
              color: Colors.white,
            ),
            title: const Text("Forum", style: TextStyle(color: Colors.white)),
          ),
          const Divider(),
          ListTile(
            onTap: (){
               Navigator.of(context)
                  .pushReplacementNamed(EventHomeScreen.routeName);
            },
            leading: const Icon(
              Icons.event,
              color: Colors.white,
            ),
            title: const Text("Events", style: TextStyle(color: Colors.white)),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
            onTap: () {
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).logoutUser();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
