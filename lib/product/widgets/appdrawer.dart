import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/blogs/screens/bloghomescreen.dart';
import 'package:gamingmob/eventmanagement/screens/eventhomescreen.dart';
import 'package:gamingmob/forum/screens/forumhomescreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';
import 'package:gamingmob/userprofile/screens/userprofilescreen.dart';
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
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(

                  
              
               FirebaseAuth.instance.currentUser!.photoURL ??
                  "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f",
            )),
            title: Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10, right: 25),
              child: GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushNamed(UserProfileScreen.routeName);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  child: const Center(
                      child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ForumHomeScreen.routeName);
            },
            leading: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
            title: const Text("Forum", style: TextStyle(color: Colors.white)),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.event,
              color: Colors.white,
            ),
            title: const Text("Events", style: TextStyle(color: Colors.white)),
            onTap: () {
              
              Navigator.of(context).pushReplacementNamed(EventHomeScreen.routeName);
            },
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
