import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/models/event.dart';
import 'package:http/http.dart' as http;

class EventProvider with ChangeNotifier {
  List<Events> _events = [];

  List<Events> get userEvents {
    var currentUser = FirebaseAuth.instance.currentUser;
    return _events
        .where((element) => element.eventUserID == currentUser!.uid)
        .toList();
  }

  List<Events> get events {
    // var currentUser = FirebaseAuth.instance.currentUser;
    return _events;
        
  }

  Future<void> updateEvent(Events newEvent) async {
    try {
      FirebaseFirestore.instance
          .collection("Events")
          .doc(newEvent.eventID)
          .update({
        "eventUserID": newEvent.eventUserID,
        "eventName": newEvent.eventName,
        "address":newEvent.address,

        // "streetName": newEvent.streetName,
        "cityName": newEvent.cityName,
        // "countryName": newEvent.countryName,
        "eventImageUrl": newEvent.eventImageUrl,
        "eventDescription": newEvent.eventDescription,
        "userRegistered": newEvent.usersRegistered,
        "eventDate": newEvent.eventDate.toString(),
        "eventTime": newEvent.eventTime,
        // "ticketCapacity": newEvent.ticketCapacity
      });
    } catch (E) {
      //  print(E);
      rethrow;
    }

    notifyListeners();
  }

  Events getById(id) {
    return _events.firstWhere((element) => element.eventID == id);
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
      for (var element in objDocks) {
        var registeredUsers = await FirebaseFirestore.instance
            .collection("Events")
            .doc(element.id)
            .collection("registeredUsers")
            .snapshots()
            .first;

        List<RegisteredUsers> list = [];
        for (var i in registeredUsers.docs) {
          list.add(RegisteredUsers(
            userID: i["userID"],
            userName: i["userName"],
          ));
        }

        try {
          fetchedEvents.add(Events(
            address: element["address"],
            eventName: element["eventName"],
              organizerEmail: element["organizerEmail"],
              eventUserID: element["eventUserID"],
              eventID: element.id,
              eventImageUrl: element["eventImageUrl"],
              cityName: element["cityName"],
              eventDescription: element["eventDescription"],
              usersRegistered: list,
              eventDate: element["eventDate"],
              eventTime: element["eventTime"]));
        } catch (ee) {
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
      "address":item.address,
      "organizerEmail": item.organizerEmail,
      "eventUserID": item.eventUserID,
      "eventName": item.eventName,
      "cityName": item.cityName,
      "eventImageUrl": item.eventImageUrl,
      "eventDescription": item.eventDescription,
      "userRegistered": [],
      "eventDate": item.eventDate.toString(),
      "eventTime": item.eventTime
    });
    notifyListeners();
  }

  Future<bool> checkIsUserRegistered(userID, eventID) async {
    var userRegistered = false;
    var obj = await FirebaseFirestore.instance
        .collection("Events")
        .doc(eventID)
        .collection("registeredUsers")
        .snapshots()
        .first;

    // print(obj.docs);
    for (var registeredUsersElement in obj.docs) {
      if (registeredUsersElement["userID"] == userID) {
        userRegistered = true;
      }
    }

    return userRegistered;
  }

  Future<String> checkStatus(userID, eventID) async {
    String status = "";
    var obj = await FirebaseFirestore.instance
        .collection("Events")
        .doc(eventID)
        .collection("registeredUsers")
        .snapshots()
        .first;

    // print(obj.docs);
    for (var registeredUsersElement in obj.docs) {
      if (registeredUsersElement["userID"] == userID) {
        status = registeredUsersElement["statusAccepted"];
      }
    }
    return status;
  }

  Future<dynamic> registerUser(RegisteredUsers user, String eventID) async {
    var eventObj = _events.firstWhere((element) => element.eventID == eventID);

    var obj = await FirebaseFirestore.instance
        .collection("Events")
        .doc(eventID)
        .collection("registeredUsers")
        .snapshots()
        .first;

    for (var i in obj.docs) {
      if (i.data()["userID"] == user.userID) {
        return "Error2";
      }
    }
    await FirebaseFirestore.instance
        .collection("Events")
        .doc(eventID)
        .collection("registeredUsers")
        .add(({
          "userID": user.userID,
          "userName": user.userName,
        }));
    await sendEmail(FirebaseAuth.instance.currentUser!.displayName ?? "",
        eventObj.organizerEmail, eventObj.eventName, obj.docs.length);
         notifyListeners();
  }


  


Future sendEmail(String name, String email, String eventName, int count) async {
  var counted = count + 1;

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_enivazl';
  const templateId = 'template_vcw2w1m';
  const userId = 'XWlCa7IIk0e-jePbq';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_name': name,
          'eventName': eventName,
          "reciever_email": email,
          // 'message': message
          "member count": "$counted"
        }
      }));

  return response;
}

}