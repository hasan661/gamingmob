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
    var height =MediaQuery.of(context).size.height;

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
                    Text(
                    "Title",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    event.eventName,
                  ),
                   const SizedBox(
                    height: 16,
                  ),
                    Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    event.eventDescription,
                  ),
                   const SizedBox(
                    height: 16,
                  ),
                    // ),
                       Text(
                    "Address",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    event.address +
                          "," +
                          event.cityName
                  ),
                   const SizedBox(
                    height: 16,
                  ),
                  
                    if (event.organizerEmail !=
                        FirebaseAuth.instance.currentUser!.email)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child:  ElevatedButton(
                      onPressed: () async {
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
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registered Successfully")));
                                        }
                                        
                      },
                      child: const Text("Register"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor.withOpacity(1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                              Size(screenWidth, height * 0.06))),
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
