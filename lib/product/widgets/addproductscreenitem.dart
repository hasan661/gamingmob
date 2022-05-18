import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreenItem extends StatefulWidget {
  const AddProductScreenItem({
    Key? key,
  }) : super(key: key);
  @override
  State<AddProductScreenItem> createState() => _AddProductScreenItemState();
}

class _AddProductScreenItemState extends State<AddProductScreenItem> {
  final List<File?> _pickedImage = [];
  var activeindex = 0;
  List<String> imageUrl = [];
  void _pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedImage.add(File(image.path));
    });
  }

  final _formkey = GlobalKey<FormState>();

  var _item = Product(
    ownerEmail: "",
    imageURL: [],
    productDescripton: "",
    productID: DateTime.now().toString(),
    productName: "",
    productType: "",
    userID: "1",
    ownerMobileNum: "",
    isFavorite: false,
    productPrice: 0,
    productCategory: "Others",
    productSubCategory: "",
    ownerName: "",
  );
  var prodName = TextEditingController();
  var prodDes = TextEditingController();
  var prodPrice = TextEditingController();
  var isLoading = false;
  dynamic productid;
  var initvalue = {
    'imageURL': [],
    "prodType": "",
    "prodCat": "",
    "prodSub": ""
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      productid = ModalRoute.of(context)!.settings.arguments;
      if (productid != null) {
        _item = Provider.of<ProductProvider>(context, listen: false)
            .filterbyid(productid.toString());
        initvalue = {
          "imageURL": _item.imageURL,
          'prodType': _item.productType,
          'prodCat': _item.productCategory,
          'prodSub': _item.productSubCategory,
        };
        prodName.text = _item.productName;
        prodDes.text = _item.productDescripton;
        prodPrice.text = _item.productPrice.toString();
      }

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext context) {
    // var timer;
    var categoriesTitles =
        Provider.of<CategoryProvider>(context).categoriesTitle;
    var subCategoriesTitle = Provider.of<CategoryProvider>(context)
        .subCategories(_item.productCategory);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    void _saveForm() async {
      // var isValid;
       var isValid = _formkey.currentState!.validate();
       
       
       
      var timer = Timer.periodic(const Duration(seconds: 3), (_) {
        
      });
      timer.cancel();
       if (!isValid) {
          return;
        }

      
   
      if (!(_pickedImage.isNotEmpty || _item.imageURL.isNotEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Image is required"),
        ));
        return;
      }

      var userPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var userEmail = FirebaseAuth.instance.currentUser!.email;
      _item.imageURL.addAll(imageUrl.map((e) => e));
      _item = Product(
        ownerEmail: userEmail.toString(),
        ownerName: _item.ownerName,
        imageURL: _item.imageURL,
        productDescripton: _item.productDescripton,
        productID: _item.productID,
        productName: _item.productName,
        productType: _item.productType,
        userID: userId,
        ownerMobileNum: userPhoneNumber ?? "",
        productCategory: _item.productCategory,
        productPrice: _item.productPrice,
        productSubCategory: _item.productSubCategory,
      );
      _formkey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < _pickedImage.length; i++) {
        var ref = FirebaseStorage.instance.ref().child(
            "GamingMob/Products/${_item.userID + _item.productName + _item.productDescripton}/$i");
        await ref.putFile(File(_pickedImage[i]!.path));
        _item.imageURL.add(await ref.getDownloadURL());
      }

      _item = Product(
          ownerEmail: _item.ownerEmail,
          ownerName: _item.ownerName,
          imageURL: _item.imageURL,
          productDescripton: _item.productDescripton,
          productID: _item.productID,
          productName: _item.productName,
          productType: _item.productType,
          userID: userId,
          ownerMobileNum: userPhoneNumber ?? "",
          productCategory: _item.productCategory,
          productSubCategory: _item.productSubCategory,
          productPrice: _item.productPrice);

      if (productid == null) {
        await Provider.of<ProductProvider>(context, listen: false)
            .addproduct(_item);
      } else {
        await Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(_item);
      }

      Navigator.of(context).pop();
    }

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    width: width,
                    height: (_pickedImage.isEmpty && _item.imageURL.isEmpty)
                        ? height * 0.25
                        : null,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 2, color: Colors.white),
                    // ),
                    child: _pickedImage.isNotEmpty || _item.imageURL.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount: productid != null
                                ? _item.imageURL.length
                                : _pickedImage.length,
                            itemBuilder: (ctx, index, _) => Stack(
                              alignment: Alignment.center,
                              children: [
                                productid != null
                                    ? Image.network(
                                        _item.imageURL[index],
                                        width: width,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(_pickedImage[index]!.path),
                                        width: width,
                                        fit: BoxFit.cover,
                                        // scale: 100,
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      color: Colors.transparent,
                                      textColor: Colors.white,
                                      child: const Icon(
                                        Icons.add_circle_rounded,
                                        size: 40,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          if (productid == null) {
                                            _pickedImage.removeAt(activeindex);
                                          } else {
                                            _item.imageURL
                                                .removeAt(activeindex);
                                          }
                                        });
                                      },
                                      color: Colors.transparent,
                                      textColor: Colors.white,
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 40,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              aspectRatio: 1 / 1,

                              // pageSnapping: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  // print(index);
                                  activeindex = index;
                                });
                              },
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              _pickImage();
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
                          ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: 10),
                    child: Text(
                      "Product Name",
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
                        onSaved: (val) {
                          _item = Product(
                              ownerName: _item.ownerName,
                              isFavorite: false,
                              productPrice: _item.productPrice,
                              imageURL: _item.imageURL,
                              productDescripton: _item.productDescripton,
                              productID: _item.productID,
                              productName: val.toString(),
                              productType: _item.productType,
                              userID: _item.userID,
                              ownerMobileNum: _item.ownerMobileNum,
                              productCategory: _item.productCategory,
                              productSubCategory: _item.productSubCategory,
                              ownerEmail: _item.ownerEmail);
                        },
                        validator: (value) {
                          if (value==null || value.isEmpty ) {
                            return "Please enter the product name";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: prodName,
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
                      "Product Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: SizedBox(
                      height: height * 0.15,
                      child: TextFormField(
                        onSaved: (val) {
                          _item = Product(
                              ownerName: _item.ownerName,
                              isFavorite: false,
                              productPrice: _item.productPrice,
                              imageURL: _item.imageURL,
                              productDescripton: val.toString(),
                              productID: _item.productID,
                              productName: _item.productName,
                              productType: _item.productType,
                              userID: _item.userID,
                              ownerMobileNum: _item.ownerMobileNum,
                              productCategory: _item.productCategory,
                              productSubCategory: _item.productSubCategory,
                              ownerEmail: _item.ownerEmail);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the product description";
                          } else if (value.length < 20) {
                            return "Please describe more";
                          }
                          return null;
                        },
                        controller: prodDes,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
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
                      "Product Type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        // print(value);
                        if (value == null || value.isEmpty) {
                          return "It is required";
                        }
                        return null;
                      },
                      value: productid != null
                          ? initvalue["prodType"].toString()
                          : null,
                      items: ["Rent", "Sell"].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (val) {
                        _item = Product(
                          ownerEmail: _item.ownerEmail,
                          ownerName: _item.ownerName,
                          isFavorite: false,
                          productPrice: _item.productPrice,
                          imageURL: _item.imageURL,
                          productDescripton: _item.productDescripton,
                          productID: _item.productID,
                          productName: _item.productName,
                          productType: val.toString(),
                          userID: _item.userID,
                          ownerMobileNum: _item.ownerMobileNum,
                          productCategory: _item.productCategory,
                          productSubCategory: _item.productSubCategory,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: 10),
                    child: Text(
                      "Product Price/Rent per day",
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
                        onSaved: (val) {
                          _item = Product(
                            ownerEmail: _item.ownerEmail,
                            ownerName: _item.ownerName,
                            isFavorite: false,
                            productPrice: int.parse(val.toString()),
                            imageURL: _item.imageURL,
                            productDescripton: _item.productDescripton,
                            productID: _item.productID,
                            productName: _item.productName,
                            productType: _item.productType,
                            userID: _item.userID,
                            ownerMobileNum: _item.ownerMobileNum,
                            productCategory: _item.productCategory,
                            productSubCategory: _item.productSubCategory,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the price";
                          }
                          return null;
                        },
                        controller: prodPrice,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
                      "Product Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: DropdownButtonFormField<String>(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "You must define a category";
                        }
                        return null;
                      },
                      value: productid != null
                          ? initvalue["prodCat"].toString()
                          : null,
                      onSaved: (val) {},
                      items: categoriesTitles.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _item = Product(
                            ownerEmail: _item.ownerEmail,
                            ownerName: _item.ownerName,
                            isFavorite: false,
                            productPrice: _item.productPrice,
                            imageURL: _item.imageURL,
                            productDescripton: _item.productDescripton,
                            productID: _item.productID,
                            productName: _item.productName,
                            productType: _item.productType,
                            userID: _item.userID,
                            ownerMobileNum: _item.ownerMobileNum,
                            productCategory: val.toString(),
                            productSubCategory: _item.productSubCategory,
                          );
                        });
                      },
                    ),
                  ),
                  if (subCategoriesTitle.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: 10),
                      child: Text(
                        "Product Subcategory",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  if (subCategoriesTitle.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: DropdownButtonFormField<String>(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Subcategory must be defined";
                          }
                          return null;
                        },
                        value: productid != null
                            ? initvalue["prodSub"].toString()
                            : null,
                        onSaved: (val) {},
                        items: subCategoriesTitle.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (val) {
                          _item = Product(
                            ownerEmail: _item.ownerEmail,
                            ownerName: _item.ownerName,
                            isFavorite: false,
                            productPrice: _item.productPrice,
                            imageURL: _item.imageURL,
                            productDescripton: _item.productDescripton,
                            productID: _item.productID,
                            productName: _item.productName,
                            productType: _item.productType,
                            userID: _item.userID,
                            ownerMobileNum: _item.ownerMobileNum,
                            productCategory: _item.productCategory,
                            productSubCategory: val.toString(),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: TextButton.icon(
                        onPressed: () {
                          _saveForm();
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Save")),
                  ),
                ],
              ),
            ),
          );
  }
}
