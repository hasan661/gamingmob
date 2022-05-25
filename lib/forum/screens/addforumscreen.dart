import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/forum/models/forum.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddForumScreen extends StatefulWidget {
  const AddForumScreen({Key? key}) : super(key: key);
  static const routeName = "/addforum";

  @override
  State<AddForumScreen> createState() => _AddForumScreenState();
}

class _AddForumScreenState extends State<AddForumScreen> {
  var isLoading = false;
  dynamic forumID;
  String? imageUrl;
  final _formKey = GlobalKey<FormState>();
  var _forumItem = Forum(
    comments: [],
    forumId: DateTime.now().toString(),
    userID: "",
    userName: "",
    forumText: "",
    likeList: [],
    imageURL: null,
    createdAt: DateTime.now(),
    userImageUrl: null,
  );
  File? imageFile;
  final forumText = TextEditingController();
  var initValues = {
    "forumText": "",
    "imageURL": "",
  };
  var isInit = true;

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
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
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      forumID = ModalRoute.of(context)!.settings.arguments;
      if (forumID != null) {
        var initForumItem = Provider.of<ForumProvider>(context, listen: false)
            .getForumByID(forumID);
        forumText.text = initForumItem.forumText;
        initValues["imageURL"] = initForumItem.imageURL ?? "";
      }
      isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var auth = FirebaseAuth.instance.currentUser;
    var forumObj = Provider.of<ForumProvider>(context);
    _postForum() async {
      var isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        isLoading=true;
      });
      if (forumID == null) {
        var fireStorgaeObj = FirebaseStorage.instance.ref();
        if (imageFile != null) {
          var homeImageReference = fireStorgaeObj
              .child("GamingMob/BlogsHome/${imageFile!.path + forumText.text}");
          await homeImageReference.putFile(File(imageFile!.path));
          imageUrl = await homeImageReference.getDownloadURL();
        }
        _forumItem = Forum(
            comments: _forumItem.comments,
            forumId: _forumItem.forumId,
            userID: _forumItem.userID,
            userName: _forumItem.userName,
            forumText: _forumItem.forumText,
            likeList: _forumItem.likeList,
            imageURL: imageUrl,
            createdAt: _forumItem.createdAt,
            userImageUrl: _forumItem.userImageUrl);
        forumObj.addForum(_forumItem);
      } else if (initValues["imageURL"] != "") {
        forumObj.updateForum(
            forumID,
            Forum(
                comments: _forumItem.comments,
                forumId: _forumItem.forumId,
                userID: _forumItem.userID,
                userName: _forumItem.userName,
                forumText: forumText.text,
                likeList: _forumItem.likeList,
                imageURL: initValues["imageURL"],
                createdAt: _forumItem.createdAt,
                userImageUrl: _forumItem.userImageUrl));
      } else {
        var fireStorgaeObj = FirebaseStorage.instance.ref();
        if (imageFile != null) {
          var homeImageReference = fireStorgaeObj
              .child("GamingMob/BlogsHome/${imageFile!.path + forumText.text}");
          await homeImageReference.putFile(File(imageFile!.path));
          imageUrl = await homeImageReference.getDownloadURL();
        }
        _forumItem = Forum(
            comments: _forumItem.comments,
            forumId: _forumItem.forumId,
            userID: _forumItem.userID,
            userName: _forumItem.userName,
            forumText: _forumItem.forumText,
            likeList: _forumItem.likeList,
            imageURL: imageUrl,
            createdAt: _forumItem.createdAt,
            userImageUrl: _forumItem.userImageUrl);
        forumObj.updateForum(
          forumID,
          _forumItem,
        );
      }
      Navigator.of(context).pop();
        setState(() {
        isLoading=false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        key: UniqueKey(),
        title: const Text(
          "Add Forum",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage(auth!.photoURL ??
                                    "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f")),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(auth.displayName.toString())
                          ],
                        ),
                      ),
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  // initialValue: initValues["forumText"],
                                  maxLines: null,
                                  controller: forumText,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "What's on your mind?",
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "You cannot post an empty forum";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    _forumItem = Forum(
                                        comments: _forumItem.comments,
                                        forumId: _forumItem.forumId,
                                        userID: _forumItem.userID,
                                        userName: _forumItem.userName,
                                        forumText: val.toString(),
                                        likeList: _forumItem.likeList,
                                        imageURL: _forumItem.imageURL,
                                        createdAt: _forumItem.createdAt,
                                        userImageUrl: _forumItem.userImageUrl);
                                  },
                                ),
                              ),
                              if (initValues["imageURL"] != "")
                                Stack(
                                  children: [
                                    Image.network(initValues["imageURL"] ?? ""),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            initValues["imageURL"] = "";
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ],
                                )
                              else if (imageFile != null)
                                Stack(
                                  children: [
                                    Image.file(File(imageFile!.path)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            imageFile = null;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: height * 0.08,
                            width: width * 0.4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        _getFromCamera();
                                      },
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text(
                                        "Camera",
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.08,
                            width: width * 0.4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        _getFromGallery();
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text("Gallery",
                                          style:
                                              TextStyle(color: Colors.black)))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: ElevatedButton(
                          onPressed: () {
                            _postForum();
                          },
                          child: const Text("Post"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: Size(width, 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
