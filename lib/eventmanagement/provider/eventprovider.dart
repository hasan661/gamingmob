import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/models/event.dart';
import 'package:http/http.dart' as http;

class EventProvider with ChangeNotifier {
  List<Events> _events = [];

  List<Events> get userEvents {
    var currentUser=FirebaseAuth.instance.currentUser;
    return _events.where((element) => element.eventUserID==currentUser!.uid).toList();
  }
  List<Events> get notUserEvents{
     var currentUser=FirebaseAuth.instance.currentUser;
    return _events.where((element) => element.eventUserID!=currentUser!.uid).toList();

  }

    Future<void> updateEvent(Events newEvent) async{
    
   try{
      FirebaseFirestore.instance.collection("Events").doc(newEvent.eventID).update({
      "eventUserID":newEvent.eventUserID,
      "eventName": newEvent.eventName,
      "eventPrice": newEvent.eventPrice,
      "streetNo": newEvent.streetNo,
      "streetName":newEvent.streetName ,
      "cityName":newEvent.cityName,
      "countryName":newEvent.countryName,
      "eventImageUrl": newEvent.eventImageUrl,
      "eventDescription": newEvent.eventDescription,
      "userRegistered": newEvent.usersRegistered,
      "eventDate": newEvent.eventDate.toString(),
      "eventTime": newEvent.eventTime
     
    });
   }
   catch(E){
    //  print(E);
    rethrow;
   }
    
    notifyListeners();
  }

  Events getById(id){
    return _events.firstWhere((element) => element.eventID==id);
  }

  Future<void> removeAnEvent(id) async {
    try {
      FirebaseFirestore.instance.doc("Events/$id").delete();
      _events.removeWhere((element) => element.eventID == id);
      notifyListeners();
    } catch (E) {
      rethrow;
    }
  }

  Future<void> fetchEvents() async {
    
    try {
      List<Events> fetchedEvents = [];
      var blogObj = await FirebaseFirestore.instance
          .collection("Events")
          .snapshots()
          .first;

      var objDocks = blogObj.docs;
      // print(objDocks);
      for (var element in objDocks) {
        List<Map<String, String>> list = [];
        element["userRegistered"].forEach((el) {
          list.add({"userID": el["userID"], "userName": el["userName"]});
        });

      try{
        fetchedEvents.add(Events(
          organizerEmail: element["organizerEmail"],
            eventUserID: element["eventUserID"],
            eventID: element.id,
            eventImageUrl: element["eventImageUrl"],
            streetNo: element["streetNo"],
            streetName:element["streetName"] ,
            cityName: element["cityName"],
            countryName: element["countryName"],
            eventName: element["eventName"],
            eventPrice: element["eventPrice"],
            eventDescription: element["eventDescription"],
            usersRegistered: list,
            eventDate: element["eventDate"],
            eventTime: element["eventTime"]));
      }
      catch(ee){
        rethrow;
      }
      }
      _events = fetchedEvents;
      
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEvent(Events item) async {
    FirebaseFirestore.instance.collection("Events").doc().set({
      "organizerEmail":item.organizerEmail,
      "eventUserID":item.eventUserID,
      "eventName": item.eventName,
      "eventPrice": item.eventPrice,
       "streetNo": item.streetNo,
      "streetName":item.streetName ,
      "cityName":item.cityName,
      "countryName":item.countryName,
     
      "eventImageUrl": item.eventImageUrl,
      "eventDescription": item.eventDescription,
      "userRegistered": [],
      "eventDate": item.eventDate.toString(),
      "eventTime": item.eventTime
    });

    // _blogs.add(item);
    notifyListeners();
  }

  Future sendEmail(String name, String email,)async{
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_enivazl';
  const templateId = 'template_vcw2w1m';
  const userId = 'XWlCa7IIk0e-jePbq';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': name,
          'from_name': email,
          'eventName':"Zabefest"
          // 'message': message
        }
      }));
      print(response.body);
  return response;
  }
}
