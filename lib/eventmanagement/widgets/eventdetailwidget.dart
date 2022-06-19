import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/provider/eventprovider.dart';
import 'package:provider/provider.dart';

class EventDetailWidget extends StatelessWidget {
  const EventDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as String;
    var event = Provider.of<EventProvider>(context).getById(id);
    var screenWidth = MediaQuery.of(context).size.width;

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                "Price:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                event.eventPrice.toString(),
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 20),
              ),
              const Text(
                "Address:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
