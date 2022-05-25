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
  var homeImageUrl = "";
  dynamic id;
  String? initHomeImage;
  var isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      id = ModalRoute.of(context)!.settings.arguments;
      if (id != null) {
        var initBlogItem =
            Provider.of<BlogProvider>(context).getById(id.toString());
        initHomeImage = initBlogItem.imageURL;
        title.text = initBlogItem.title;
        listOfContent = initBlogItem.blogContent;
        for (var i in listOfContent) {
          if (i.type == "text") {
            i.data = TextEditingController(text: i.data);
          }
        }
      }
    }
  }

  final _key = GlobalKey<FormState>();
  var isLoading = false;
  Future<void> onSaveButtonClick() async {
    var isValid = _key.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (listOfContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        duration: const Duration(days: 365),

        // content:const Text("invalid password"),
        action: SnackBarAction(
            label: "Close",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            textColor: Colors.white),
        content: const Text("Blog cannot be empty"),
      ));

      return;
    }

    setState(() {
      isLoading = true;
    });

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
      if (listOfContent[i].type == "image") {
        var contentImageReference = fireStorgaeObj
            .child("GamingMob/BlogsContent/${listOfContent[i].data}");
        try {
          await contentImageReference
              .putFile(File(listOfContent[i].data.toString()));
          var url = await contentImageReference.getDownloadURL();
          listOfContent[i].data = url;
        } catch (_) {}
      } else {
        listOfContent[i].data = listOfContent[i].data.runtimeType == String
            ? TextEditingController(text: listOfContent[i].data).text
            : listOfContent[i].data.text;
      }
    }

    var item = Blog(
      id: id ?? "",
      blogContent: listOfContent,
      imageURL: id == null || initHomeImage == null || initHomeImage == ""
          ? homeImageUrl
          : initHomeImage.toString(),
      title: title.text,
      blogCreationDate: DateTime.now(),
      userId: userID,
      userName: userName ?? "",
    );
    if (id == null) {
      await Provider.of<BlogProvider>(context, listen: false).addBlogs(item);
    } else {
      await Provider.of<BlogProvider>(context, listen: false).updateBlog(item);
    }

    Navigator.of(context).pop();
  }

  var textBoxText = TextEditingController();
  File? image;
  File? homeImage;
  var title = TextEditingController();
  List<BlogContent> listOfContent = [];

  void pickAnImage(index) async {
    final imageDummy = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      image = File(imageDummy!.path);
      listOfContent.removeAt(index);

      listOfContent.insert(
          index, BlogContent(data: image!.path, type: "image"));

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
                  height: homeImage == null && initHomeImage == null ||
                          initHomeImage == "" && id == null
                      ? height * 0.25
                      : null,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: homeImage == null
                      ? initHomeImage == null || initHomeImage == ""
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
                                Image.network(
                                  initHomeImage.toString(),
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      initHomeImage = null;
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
                            listOfContent
                                .add(BlogContent(data: a, type: "image"));
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
                            listOfContent
                                .add(BlogContent(data: data, type: "text"));
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
                      return listOfContent[index].type == "text"
                          ? Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextFormField(
                                      controller: listOfContent[index].data,
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
                                listOfContent[index].data == null ||
                                        listOfContent[index].data == ""
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: width,
                                            height: listOfContent[index].data ==
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
                                          id == null
                                              ? Image.file(
                                                  File(listOfContent[index]
                                                      .data),
                                                  fit: BoxFit.cover,
                                                )
                                              : listOfContent[index]
                                                      .data
                                                      .toString()
                                                      .startsWith("/")
                                                  ? Image.file(
                                                      File(listOfContent[index]
                                                          .data),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      listOfContent[index]
                                                          .data),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                listOfContent.removeAt(index);
                                              });
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
