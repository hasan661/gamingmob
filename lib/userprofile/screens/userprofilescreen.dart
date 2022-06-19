import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/userprofile/widgets/userprofiletab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static const routeName = "/userprofile";

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? imageFile;
  uploadImage(File a) async {
    await Provider.of<AuthProvider>(context, listen: false).updateProfileUrl(a);
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    uploadImage(File(imageFile!.path));
  }

  _getFromCamera() async {
    // ignore: deprecated_member_use
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    uploadImage(File(imageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var coverHeight = height * 0.35;
    var profileHeight = height * 0.2;
    var top = coverHeight - profileHeight / 2;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Container(
                          height: coverHeight,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: profileHeight / 1.8),
                          color: Colors.grey,
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FCDs.jpg?alt=media&token=a762713a-f738-4925-a603-0c38625bbe51",
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        top: top,
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return SizedBox(
                                      height: height * 0.17,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Navigator.of(ctx).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return SizedBox(
                                                      height: height,
                                                      width: double.infinity,
                                                      child: Dialog(
                                                        child: PhotoView(
                                                          
                                                          
                                                          imageProvider: NetworkImage(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .photoURL ??
                                                                  "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f"),
                                                        
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            leading: const Icon(
                                                Icons.remove_red_eye),
                                            title: const Text("View Image"),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return SizedBox(
                                                      height: height * 0.17,
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            onTap: () {
                                                              _getFromGallery();
                                                            },
                                                            leading: const Icon(
                                                              Icons
                                                                  .image_outlined,
                                                            ),
                                                            title: const Text(
                                                                "Gallery"),
                                                          ),
                                                          ListTile(
                                                            onTap: () {
                                                              _getFromCamera();
                                                            },
                                                            leading: const Icon(
                                                              Icons.camera,
                                                            ),
                                                            title: const Text(
                                                                "Camera"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            leading:
                                                const Icon(Icons.image_sharp),
                                            title: const Text("Update Image"),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) => CircleAvatar(
                                radius: profileHeight / 2,
                                backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser!.photoURL ??
                                    "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f"),
                              ),
                            ))),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const UserProfileTab()
              ],
            );
          }
        }),
      ),
    );
  }
}
