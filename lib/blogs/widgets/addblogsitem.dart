import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogsItem extends StatefulWidget {
  AddBlogsItem(
      {Key? key,
      required this.listOfBlogContent,
      required this.assigner,
      required this.homeImageAssigner,
      required this.homeTitle})
      : super(key: key);
  List<Map<String, String>> listOfBlogContent = [];
  final void Function(Map<String, String>) assigner;
  final void Function(String) homeTitle;
  final void Function(File) homeImageAssigner;

  @override
  State<AddBlogsItem> createState() => _AddBlogsItemState();
}

class _AddBlogsItemState extends State<AddBlogsItem> {
  final _formkey = GlobalKey<FormState>();
  List<Widget> screenDesign = [];
  var textBoxText = TextEditingController();
  File? image;
  File? homeImage;
  var title = TextEditingController();

  void pickHomeImage() async {
    final imageDummy =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      homeImage = File(imageDummy!.path);
      widget.homeImageAssigner(File(homeImage!.path));
    });
  }

  void pickAnImage() async {
    final imageDummy =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageDummy!.path);
      widget.assigner({"type": "image", "data": image!.path});
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    
    var height = MediaQuery.of(context).size.height;
    var blogTitle=TextEditingController();
    Widget textBox = Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Form(
            key: _formkey,
            child: TextFormField(
              controller: textBoxText,
              onSaved: (val) {
                setState(() {
                  widget.assigner({"type": "text", "data": textBoxText.text});
                });
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.next,
              toolbarOptions:
                  const ToolbarOptions(cut: true, copy: true, paste: true),
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Type here",
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _formkey.currentState!.save();
                  screenDesign = [];
                });
              },
              child: const Text("Done"))
        ],
      ),
    );

    Widget imageLook = Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            width: width,
            height: height * 0.25,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: MaterialButton(
              onPressed: () {
                pickAnImage();
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
            )),
      ],
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height * 0.25,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: homeImage==null? MaterialButton(
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
            ):Image.file(File(homeImage!.path),fit: BoxFit.cover,),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
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
                
                onChanged: (val){
                  widget.homeTitle(val.toString());
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the product name";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                toolbarOptions:
                    const ToolbarOptions(cut: true, copy: true, paste: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
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
                      screenDesign = [];
                      screenDesign.add(imageLook);
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
                    // print(screenDesign.contains(textBox).toString()+"qasim");
                    setState(() {
                      screenDesign = [];
                      screenDesign.add(textBox);
                      textBoxText.text = "";
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: screenDesign.length,
            itemBuilder: (context, index) {
              return screenDesign[index];
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.listOfBlogContent.map(
                (e) {
                  return e["type"] == "text"
                      ? Text(e["data"].toString())
                      : Image.file(File(e["data"].toString()));
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
