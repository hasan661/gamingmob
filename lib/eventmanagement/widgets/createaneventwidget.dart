import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/models/event.dart';
import 'package:gamingmob/eventmanagement/provider/eventprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateAnEventWidget extends StatefulWidget {
  const CreateAnEventWidget({Key? key}) : super(key: key);

  @override
  State<CreateAnEventWidget> createState() => _CreateAnEventWidgetState();
}

class _CreateAnEventWidgetState extends State<CreateAnEventWidget> {
  String? id;
  var isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      id = ModalRoute.of(context)!.settings.arguments as String;
      if (id != null) {
        var initEventItem =
            Provider.of<EventProvider>(context).getById(id.toString());
        eventName.text=initEventItem.eventName;
        eventPrice.text=initEventItem.eventPrice.toString();
        streetNo.text=initEventItem.streetNo;
        streetName.text=initEventItem.streetName;
        cityName.text=initEventItem.cityName;
        countryName.text=initEventItem.countryName;
        eventDescription.text=initEventItem.eventDescription;
        eventDate.text=initEventItem.eventDate;
        eventTime.text=initEventItem.eventTime;
        _pickedImageUrl=initEventItem.eventImageUrl;
     
      }
    }
  }
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var eventName = TextEditingController();
  var eventPrice = TextEditingController();
  var streetNo = TextEditingController();
  var streetName = TextEditingController();
  var cityName = TextEditingController();
  var countryName = TextEditingController();
  var eventDescription = TextEditingController();
  var eventDate = TextEditingController();
  var eventTime = TextEditingController();
  var eventItem = Events(
    eventUserID: "",
    eventID: "",
    eventImageUrl: "",
    cityName: "",
    countryName: "",
    streetName: "",
    streetNo: "",
    eventName: "",
    eventPrice: 0,
    eventDescription: "",
    usersRegistered: [],
    eventDate: DateTime.now().toString(),
    eventTime: "",
  );

  dynamic _pickedImage;
  String? _pickedImageUrl;
  var activeindex = 0;

  void _saveForm() async {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    var currentUser = FirebaseAuth.instance.currentUser;
    var userID = currentUser!.uid;
    // var userName = currentUser.displayName;
    var fireStorgaeObj = FirebaseStorage.instance.ref();
    if (_pickedImage != null) {
      var homeImageReference =
          fireStorgaeObj.child("GamingMob/BlogsHome/${_pickedImage!.path}");
      await homeImageReference.putFile(File(_pickedImage!.path));
      _pickedImageUrl = await homeImageReference.getDownloadURL();
    }

    var item = Events(
      eventUserID: userID,
        eventID: id??"",
        eventImageUrl: _pickedImageUrl ?? "",
        streetNo: streetNo.text,
        streetName: streetName.text,
        cityName: cityName.text,
        countryName: countryName.text,
        eventName: eventName.text,
        eventPrice: int.parse(eventPrice.text),
        eventDescription: eventDescription.text,
        usersRegistered: [],
        eventDate: eventDate.text,
        eventTime: eventTime.text);
    if (id == null) {
      await Provider.of<EventProvider>(context, listen: false).addEvent(item);
    } else {
      await Provider.of<EventProvider>(context, listen: false).updateEvent(item);
    }

    Navigator.of(context).pop();
  }

  void _pickImage(ImageSource a) async {
    final image = await ImagePicker().pickImage(source: a, imageQuality: 20);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    showModal() {
      showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return SizedBox(
              height: height * 0.17,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    leading: const Icon(
                      Icons.image_outlined,
                    ),
                    title: const Text("Gallery"),
                  ),
                  ListTile(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                    },
                    leading: const Icon(
                      Icons.camera,
                    ),
                    title: const Text("Camera"),
                  ),
                ],
              ),
            );
          });
    }

    presentDatePicker() async {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1));
      setState(() {
        eventDate.text = date != null ? DateFormat.yMd().format(date) : "";
      });
    }

    presentTimePicker() async {
      TimeOfDay time = await showTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 0, minute: 0)) ??
          const TimeOfDay(hour: 0, minute: 0);
      setState(() {
        eventTime.text = time.hour.toString() + ":" + time.minute.toString();
      });
    }

    var width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: _pickedImage == null && id==null ? height * 0.25 : null,
              width: width,
              child: _pickedImage == null && id==null
                  ? MaterialButton(
                      onPressed: () {
                        showModal();
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
                  : id==null? Image.file(_pickedImage):Image.network(_pickedImageUrl??""),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
              child: Text(
                "Event Name",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: eventName,
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
                "Event Price",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: eventPrice,
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
                "Street No",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: streetNo,
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
                "Street Name",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: streetName,
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
                "City",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: cityName,
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
                "Country",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: countryName,
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
                "Event Description",
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
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  controller: eventDescription,
                  // keyboardAppearance: ,
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
                "Event Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: GestureDetector(
                  onTap: presentDatePicker,
                  child: Container(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      height: height * 0.076,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Text(eventDate.text)),
                )),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
              child: Text(
                "Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: GestureDetector(
                  onTap: presentTimePicker,
                  child: Container(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      height: height * 0.076,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Text(eventTime.text)),
                )),
            Center(
              child: TextButton.icon(
                  onPressed: () {
                    _saveForm();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save")),
            ),
          ],
        ));
  }
}
