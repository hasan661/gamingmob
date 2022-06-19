import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/models/event.dart';
import 'package:gamingmob/eventmanagement/provider/eventprovider.dart';
import 'package:provider/provider.dart';

class EventDetailWidget extends StatefulWidget {
  const EventDetailWidget({Key? key}) : super(key: key);

  @override
  State<EventDetailWidget> createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  String? status;
  

  @override
  Widget build(BuildContext context) {
    // bool? eventObj;
    var id = ModalRoute.of(context)!.settings.arguments as String;


    var event = Provider.of<EventProvider>(context).getById(id);
    var screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Events")
            .doc(id)
            .collection("registeredUsers")
            .snapshots(),
        builder: (context, snapshot) {
          // call();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              CachedNetworkImage(
                imageUrl: event.eventImageUrl,
                width: screenWidth,
                placeholderFadeInDuration: const Duration(seconds: 4),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      event.eventName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      event.eventDescription,
                      style: const TextStyle(fontSize: 20),
                    ),
                    
                    const Text(
                      "Address:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      event.streetNo +
                          "," +
                          event.streetName +
                          "," +
                          event.cityName +
                          "," +
                          event.countryName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (event.organizerEmail !=
                        FirebaseAuth.instance.currentUser!.email)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: ElevatedButton(
                                onPressed:() async {
                                        var credentials = RegisteredUsers(
                                            userID: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userName: FirebaseAuth.instance
                                                .currentUser!.displayName
                                                .toString(),
                                            );

                                        dynamic errorOrNot =
                                            await Provider.of<EventProvider>(
                                                    context,
                                                    listen: false)
                                                .registerUser(credentials, id);
                                        if (errorOrNot == "Error") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                Theme.of(context).errorColor,
                                            duration: const Duration(days: 365),

                                            // content:const Text("invalid password"),
                                            action: SnackBarAction(
                                                label: "Close",
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                },
                                                textColor: Colors.white),
                                            content:
                                                const Text("No seats left"),
                                          ));
                                        }
                                        else if(errorOrNot=="Error2"){
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                Theme.of(context).errorColor,
                                            duration: const Duration(days: 365),
                                            action: SnackBarAction(
                                                label: "Close",
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                },
                                                textColor: Colors.white),
                                            content:
                                                const Text("You have already registered"),
                                          ));

                                        }
                                      },
                                child: const Text("Register"),
                              ),
                      ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
