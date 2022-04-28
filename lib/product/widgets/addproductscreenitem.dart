import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreenItem extends StatefulWidget {
  const AddProductScreenItem({Key? key}) : super(key: key);

  @override
  State<AddProductScreenItem> createState() => _AddProductScreenItemState();
}

class _AddProductScreenItemState extends State<AddProductScreenItem> {
  final _formkey = GlobalKey<FormState>();
  var userPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  var _item = Product(
    imageURL: [],
    productDescripton: "",
    productID: DateTime.now().toString(),
    productName: "",
    productType: "",
    userID: "1",
    ownerMobileNum: "",
    isFavorite: false,
    productPrice: 0,
    productRentFee: 0,
    productCategory: "Others",
    productSubCategory: "",
  );
  var prodName = TextEditingController();
  var prodType = TextEditingController();
  var prodDes = TextEditingController();
  var prodPrice = TextEditingController();
  var prodImage = TextEditingController();
  var mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var categoriesTitles =
        Provider.of<CategoryProvider>(context).categoriesTitle;
    var subCategoriesTitle = Provider.of<CategoryProvider>(context)
        .subCategories(_item.productCategory);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    void _saveForm() {
      final isValid = _formkey.currentState!.validate();
      if (!isValid) {
        return;
      }

      _formkey.currentState!.save();
      Provider.of<ProductProvider>(context, listen: false).addproduct(_item);
    }

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
            child: MaterialButton(
              onPressed: () {},
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
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
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
                    isFavorite: false,
                    productPrice: _item.productPrice,
                    productRentFee: _item.productRentFee,
                    imageURL: _item.imageURL,
                    productDescripton: _item.productDescripton,
                    productID: _item.productID,
                    productName: val.toString(),
                    productType: _item.productType,
                    userID: _item.userID,
                    ownerMobileNum: _item.ownerMobileNum,
                    productCategory: _item.productCategory,
                    productSubCategory: _item.productSubCategory,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the product name";
                  }
                },
                keyboardType: TextInputType.name,
                controller: prodName,
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
                    isFavorite: false,
                    productPrice: _item.productPrice,
                    productRentFee: _item.productRentFee,
                    imageURL: _item.imageURL,
                    productDescripton: val.toString(),
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
                if (value == null) {
                  return "It is required";
                }
                return null;
              },
              value: null,
              items: ["Rent", "Sell"].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (val) {
                _item = Product(
                  isFavorite: false,
                  productPrice: _item.productPrice,
                  productRentFee: _item.productRentFee,
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
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
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
                  if (_item.productType == "Rent") {
                    _item = Product(
                      isFavorite: false,
                      productPrice: _item.productPrice,
                      productRentFee: int.parse(val.toString()),
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
                  } else {
                    _item = Product(
                      isFavorite: false,
                      productPrice: int.parse(val.toString()),
                      productRentFee: _item.productRentFee,
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
                  }
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
              value: null,
              onSaved: (val) {},
              items: categoriesTitles.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (val) {
                setState(() {
                  _item = Product(
                    isFavorite: false,
                    productPrice: _item.productPrice,
                    productRentFee: _item.productRentFee,
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
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
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
                value: null,
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
                    isFavorite: false,
                    productPrice: _item.productPrice,
                    productRentFee: _item.productRentFee,
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
    );
  }
}
