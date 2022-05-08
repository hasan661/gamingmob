import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/models/blog.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddBlogsItem extends StatefulWidget {
  const AddBlogsItem({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBlogsItem> createState() => _AddBlogsItemState();
}

class _AddBlogsItemState extends State<AddBlogsItem> {
  final _key = GlobalKey<FormState>();
  var isLoading = false;
  Future<void> onSaveButtonClick() async {
    var isValid = _key.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading=true;
    });

    var homeImageUrl = "";
    var currentUser = FirebaseAuth.instance.currentUser;
    var userID = currentUser!.uid;
    var userName = currentUser.displayName;
    var fireStorgaeObj = FirebaseStorage.instance.ref();
    if (homeImage != null) {
      var homeImageReference = fireStorgaeObj
          .child("GamingMob/BlogsHome/${homeImage!.path + title.text}");
      await homeImageReference.putFile(File(homeImage!.path));
      homeImageUrl = await homeImageReference.getDownloadURL();
    }

    for (int i = 0; i < listOfContent.length; i++) {
      if (listOfContent[i]["type"] == "image") {
        var contentImageReference = fireStorgaeObj
            .child("GamingMob/BlogsContent/${listOfContent[i]["data"]}");
        await contentImageReference
            .putFile(File(listOfContent[i]["data"].toString()));
        var url = await contentImageReference.getDownloadURL();
        listOfContent[i]["data"] = url;
      } else {
        listOfContent[i]["data"] = listOfContent[i]["data"].text;
      }
    }
    var item = Blog(
      id: "",
      blogContent: BlogContent(listOfContent),
      imageURL: homeImageUrl,
      title: title.text,
      blogCreationDate: DateTime.now(),
      userId: userID,
      userName: userName ?? "",
    );

    await Provider.of<BlogProvider>(context, listen: false).addBlogs(item);
    Navigator.of(context).pop();
  }

  var textBoxText = TextEditingController();
  File? image;
  File? homeImage;
  var title = TextEditingController();
  List<Map<String, dynamic>> listOfContent = [];

  void pickAnImage(index) async {
    final imageDummy = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      image = File(imageDummy!.path);
      listOfContent.removeAt(index);

      listOfContent.insert(index, {"type": "image", "data": image!.path});

      image = null;
    });
  }

  void pickHomeImage() async {
    final imageDummy = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      homeImage = File(imageDummy!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _key,
            child: ListView(
              children: [
                Container(
                  width: width,
                  height: homeImage == null ? height * 0.25 : null,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: homeImage == null
                      ? MaterialButton(
                          onPressed: () {
                            pickHomeImage();
                          },
                          color: Colors.grey,
                          textColor: Colors.white,
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                        )
                      : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.file(
                              File(homeImage!.path),
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    homeImage = null;
                                  });
                                },
                                icon: const Icon(Icons.cancel))
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
                  child: Text(
                    "Blog Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: SizedBox(
                    height: height * 0.076,
                    child: TextFormField(
                      controller: title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the blog title";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      toolbarOptions: const ToolbarOptions(
                          cut: true, copy: true, paste: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
                  child: Text(
                    "Blog Content",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            File? a;
                            listOfContent.add({"type": "image", "data": a});
                          });
                        },
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 40,
                        ),
                        padding: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            var data = TextEditingController();
                            listOfContent.add({"type": "text", "data": data});
                          });
                        },
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: const Icon(
                          Icons.edit,
                          size: 40,
                        ),
                        padding: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listOfContent.length,
                    itemBuilder: (context, index) {
                      return listOfContent[index]["type"] == "text"
                          ? Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextFormField(
                                      controller: listOfContent[index]["data"],
                                      
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      textInputAction: TextInputAction.next,
                                      toolbarOptions: const ToolbarOptions(
                                          cut: true, copy: true, paste: true),
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
                                        hintText: "Type here",
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      listOfContent.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                listOfContent[index]["data"] == null
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: width,
                                            height: listOfContent[index]
                                                        ["data"] ==
                                                    null
                                                ? height * 0.25
                                                : null,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                pickAnImage(index);
                                              },
                                              color: Colors.grey,
                                              textColor: Colors.white,
                                              child: const Icon(
                                                Icons.add,
                                                size: 40,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                listOfContent.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(Icons.cancel),
                                          )
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Image.file(
                                            File(listOfContent[index]["data"]),
                                            fit: BoxFit.cover,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              listOfContent.removeAt(index);
                                            },
                                            icon: const Icon(Icons.cancel),
                                          )
                                        ],
                                      ),
                                SizedBox(
                                  height: height * 0.1,
                                ),
                              ],
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: listOfContent.isEmpty ? height * 0.2 : 0,
                ),
                TextButton.icon(
                  onPressed: () {
                    onSaveButtonClick();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                )
              ],
            ),
          );
  }
}
