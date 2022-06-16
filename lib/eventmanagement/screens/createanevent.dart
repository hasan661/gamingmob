import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/widgets/createaneventwidget.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);
  static const routeName = "/createevent";

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create An Event"),
        centerTitle: true,
      ),
      body: const CreateAnEventWidget(),
    );
  }
}
