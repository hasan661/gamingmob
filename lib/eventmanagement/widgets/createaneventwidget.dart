import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  var dateFilled = true;
  var timeFilled = true;
  var imageAdded = true;
  var id;
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      id = ModalRoute.of(context)!.settings.arguments;
      if (id != null) {
        var initEventItem =
            Provider.of<EventProvider>(context).getById(id.toString());
        eventName.text = initEventItem.eventName;
        
        cityName.text = initEventItem.cityName;
        
        eventDescription.text = initEventItem.eventDescription;
        eventDate.text = initEventItem.eventDate;
        eventTime.text = initEventItem.eventTime;
        _pickedImageUrl = initEventItem.eventImageUrl;
       
      }
    }
  }

  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
 
  var eventName = TextEditingController();

  var eventAddress = TextEditingController();

  var cityName = TextEditingController();
 
  var eventDescription = TextEditingController();
  var eventDate = TextEditingController();
  var eventTime = TextEditingController();
  var eventItem = Events(
    address: "",
    organizerEmail: "",
    eventUserID: "",
    eventID: "",
    eventImageUrl: "",
    cityName: "",
    
    eventName: "",
    eventDescription: "",
    usersRegistered: [],
    eventDate: DateTime.now().toString(),
    eventTime: "",
  );

  dynamic _pickedImageFile;
  String? _pickedImageUrl;
  var activeindex = 0;

  void _saveForm() async {
    var isValid = _formKey.currentState!.validate();
    if (eventDate.text == "") {
      setState(() {
        dateFilled = false;
      });
    }
    if (eventDate.text != "") {
      setState(() {
        dateFilled = true;
      });
    }
    if (eventTime.text == "") {
      setState(() {
        timeFilled = false;
      });
    }

    if (eventTime.text != "") {
      setState(() {
        timeFilled = true;
      });
    }

    if (_pickedImageUrl == null && _pickedImageFile == null) {
      setState(() {
        imageAdded = false;
      });
    } else {
      setState(() {
        imageAdded = true;
      });
    }
    if (!isValid ||
        eventDate.text == "" ||
        (_pickedImageFile == null && _pickedImageUrl == null)) {
      return;
    }
    if (_pickedImageFile != null) {
      var homeImageReference = FirebaseStorage.instance
          .ref()
          .child("GamingMob/BlogsHome/${_pickedImageFile!.path}");
      await homeImageReference.putFile(File(_pickedImageFile!.path));
      _pickedImageUrl = await homeImageReference.getDownloadURL();
    }

    setState(() {
      isLoading = true;
    });

    var currentUser = FirebaseAuth.instance.currentUser;
    var userID = currentUser!.uid;
    // var userName = currentUser.displayName;
    var fireStorgaeObj = FirebaseStorage.instance.ref();

    if (_pickedImageFile != null) {
      var homeImageReference =
          fireStorgaeObj.child("GamingMob/BlogsHome/${_pickedImageFile!.path}");
      await homeImageReference.putFile(File(_pickedImageFile!.path));
      _pickedImageUrl = await homeImageReference.getDownloadURL();
    }

    var item = Events(
      address: eventAddress.text,
        organizerEmail: currentUser.email ?? "",
        eventUserID: userID,
        eventID: id ?? "",
        eventImageUrl: _pickedImageUrl ?? "",
        
        cityName: cityName.text,
      
        eventName: eventName.text,
        eventDescription: eventDescription.text,
        usersRegistered: [],
        eventDate: eventDate.text,
        eventTime: eventTime.text);
    if (id == null) {
      await Provider.of<EventProvider>(context, listen: false).addEvent(item);
    } else {
      await Provider.of<EventProvider>(context, listen: false)
          .updateEvent(item);
    }

    Navigator.of(context).pop();
  }

  void _pickImage(ImageSource a) async {
    final image = await ImagePicker().pickImage(source: a, imageQuality: 20);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(image.path);
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
                      Navigator.of(ctx).pop();
                    },
                    leading: const Icon(
                      Icons.image_outlined,
                    ),
                    title: const Text("Gallery"),
                  ),
                  ListTile(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(ctx).pop();
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height:
                          _pickedImageFile == null && _pickedImageUrl == null ||
                                  _pickedImageUrl == "" && id == null
                              ? height * 0.25
                              : null,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: _pickedImageFile == null
                          ? _pickedImageUrl == null || _pickedImageUrl == ""
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
                              : Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    CachedNetworkImage(
                                      placeholderFadeInDuration:
                                          const Duration(seconds: 4),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      imageUrl: _pickedImageUrl.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _pickedImageUrl = null;
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
                                  File(_pickedImageFile!.path),
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _pickedImageFile = null;
                                      });
                                    },
                                    icon: const Icon(Icons.cancel))
                              ],
                            ),
                    ),
                    if (!imageAdded)
                      const Padding(
                          padding: EdgeInsets.only(
                            left: 17,
                            top: 5,
                          ),
                          child: Text(
                            "Image is Required",
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
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
                  child: TextFormField(
                    onSaved: (val) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the event name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: eventName,
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
              
                
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
                  child: Text(
                    "Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: TextFormField(
                    onSaved: (val) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the street no";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                    controller: eventAddress,
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
               
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
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
                  child: TextFormField(
                    onSaved: (val) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the city";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: cityName,
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
                
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
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
                  child: TextFormField(
                    onSaved: (val) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the event description name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: eventDescription,
                    // keyboardAppearance: ,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(top: 15, left: 10),
                              height: height * 0.076,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: !dateFilled
                                          ? Colors.red
                                          : Colors.grey)),
                              child: Text(eventDate.text)),
                          if (!dateFilled)
                            const Padding(
                                padding: EdgeInsets.only(
                                  left: 17,
                                  top: 5,
                                ),
                                child: Text(
                                  "Please Enter The Date",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                ))
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(top: 15, left: 10),
                              height: height * 0.076,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        !timeFilled ? Colors.red : Colors.grey,
                                  )),
                              child: Text(eventTime.text)),
                          if (!timeFilled)
                            const Padding(
                                padding: EdgeInsets.only(
                                  left: 17,
                                  top: 5,
                                ),
                                child: Text(
                                  "Please Enter The Time",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                ))
                        ],
                      ),
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
