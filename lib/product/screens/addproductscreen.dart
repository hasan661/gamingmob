import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  static const routeName = "/addproduct";
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
  );
  var prodName = TextEditingController();
  var prodType = TextEditingController();
  var prodDes = TextEditingController();
  var prodPrice = TextEditingController();
  var prodImage = TextEditingController();
  var mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _saveForm() {
      final isValid = _formkey.currentState!.validate();
      if (!isValid) {
        return;
      }

      _formkey.currentState!.save();
      Provider.of<ProductProvider>(context, listen: false).addproduct(_item);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Add Your Products"),centerTitle: true,),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Product Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  controller: prodName,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please provide a name";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
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
                    );
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    helperText: "Specify Only The Name Of the product",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Product Type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: DropdownButtonFormField<String>(
                  value: null,
                  onSaved: (val) {},
                  items: ["Rent", "Sell"].map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    helperText: "Specify The Product Type",
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
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Product Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  controller: prodDes,
                  textInputAction: TextInputAction.next,
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
                    );
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please provide a description";
                    } else {
                      return null;
                    }
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  toolbarOptions:
                      const ToolbarOptions(cut: true, copy: true, paste: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    helperText: "Descibe The Condition Of The Product",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Product Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  controller: prodPrice,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please provide a price";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  onSaved: (val) {
                    if (prodType.text == "Rent") {
                      _item = Product(
                          isFavorite: false,
                          productPrice: int.parse(val.toString()),
                          imageURL: _item.imageURL,
                          productDescripton: _item.productDescripton,
                          productID: _item.productID,
                          productName: _item.productName,
                          productType: _item.productType,
                          userID: _item.userID,
                          ownerMobileNum: _item.ownerMobileNum,
                          productRentFee: int.parse(val.toString()),
                          );
                    } else {
                      
                      _item = Product(
                          imageURL: _item.imageURL,
                          productDescripton: _item.productDescripton,
                          productID: _item.productID,
                          productName: _item.productName,
                          productType: _item.productType,
                          userID: _item.userID,
                          ownerMobileNum: _item.ownerMobileNum,
                          productRentFee: int.parse(val.toString()),
                          productPrice: int.parse(val.toString()));
                    }
                  },
                  toolbarOptions:
                      const ToolbarOptions(cut: true, copy: true, paste: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    helperText:
                        "If the product is for renting tell how much you want for a day",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Image Url",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  controller: prodImage,
                  textInputAction: TextInputAction.next,
                  onSaved: (val) {
                    _item = Product(
                      imageURL: [val.toString()],
                      productDescripton: _item.productDescripton,
                      productID: _item.productID,
                      productName: _item.productName,
                      productType: _item.productType,
                      userID: _item.userID,
                      ownerMobileNum: _item.ownerMobileNum,
                      productPrice: _item.productPrice,
                      productRentFee: _item.productRentFee
                    );
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please provide an image url";
                    } else {
                      return null;
                    }
                  },
                  toolbarOptions:
                      const ToolbarOptions(cut: true, copy: true, paste: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Your Mobile Number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  controller: mobileNumber,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please provide a mobile number";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
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
                      ownerMobileNum: val.toString(),
                    );
                  },
                  toolbarOptions:
                      const ToolbarOptions(cut: true, copy: true, paste: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    helperText: "Please Enter so the customer can contact you",
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    _saveForm();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
