import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/provider/eventprovider.dart';
import 'package:provider/provider.dart';

class EventHomeWidget extends StatelessWidget {
  const EventHomeWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Events")
          .snapshots(),
      builder: (context,snapshot) {
        return FutureBuilder(
          future: Provider.of<EventProvider>(context).fetchEvents(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            var eventData = Provider.of<EventProvider>(
          context,
        ).notUserEvents;
        
            return ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image.network(
                                  eventData[index].eventImageUrl,
                                  height: height * 0.33,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 10,
                                child: Container(
                                  width: width,
                                  color: Colors.black54,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Text(
                                    eventData[index].eventName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.schedule),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(eventData[index].eventDate.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(eventData[index].streetName+eventData[index].cityName)
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "    RS",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(eventData[index].eventPrice.toString())
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
              itemCount: eventData.length,
            );
          }
        );
      }
    );
  }
}
