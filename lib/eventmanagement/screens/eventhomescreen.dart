import 'package:flutter/material.dart';
import 'package:gamingmob/eventmanagement/screens/createanevent.dart';
import 'package:gamingmob/eventmanagement/widgets/myevents.dart';
import 'package:gamingmob/eventmanagement/widgets/eventbottomappbar.dart';
import 'package:gamingmob/eventmanagement/widgets/eventhomewidget.dart';
import 'package:gamingmob/product/widgets/appdrawer.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/event-home";

  @override
  State<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  var _selectedIndex = 0;

  void selectedIndexValue(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  List<Widget> screens = const [EventHomeScreen(), MyEventsScreen(routeFrom: "",)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        centerTitle: true,
        actions: [
          _selectedIndex == 1
              ? TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateEvent.routeName);
                  },
                  child: const Text(
                    "Create An Event",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container()
        ],
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: EventBottomAppBar(
        screens: screens,
        selectedIndex: _selectedIndex,
        selectedIndexValue: selectedIndexValue,
      ),
      body: _selectedIndex == 0
          ? const EventHomeWidget()
          : const MyEventsScreen(routeFrom: "",),
    );
  }
}
