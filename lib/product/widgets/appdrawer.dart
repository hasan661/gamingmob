import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:provider/provider.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

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
              const ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text("Home", style: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                title:
                    Text("Marketplace", style: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.notes,
                  color: Colors.white,
                ),
                title: Text("Blog", style: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                title: Text("Forum", style: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                title: Text("Events", style: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title:
                    const Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).logoutUser();
                },
              ),
            ],
          ),
        );
  }
}