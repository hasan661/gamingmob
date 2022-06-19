import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/widgets/eventdetailwidget.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key? key}) : super(key: key);
  static const routeName="/event-detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EventDetail"),
      ),
      body: const EventDetailWidget(),
    );
  }
}
