import 'package:flutter/material.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';

class EventHomeScreen extends StatelessWidget {
  const EventHomeScreen({Key? key}) : super(key: key);
  static const routeName="/eventhome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Home"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Event Home ",
        ),
      ),
    );
  }
}
