import 'package:flutter/material.dart';
class EventBottomAppBar extends StatefulWidget {
  const EventBottomAppBar({ Key? key, required this.screens, required this.selectedIndex, required this.selectedIndexValue }) : super(key: key);
    final List<Widget> screens;
  final void Function(int) selectedIndexValue;
  final int selectedIndex;

  @override
  State<EventBottomAppBar> createState() => _EventBottomAppBarState();
}

class _EventBottomAppBarState extends State<EventBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(
          0xff8d1ba5,
        ),
      ),
      child: BottomNavigationBar(
        onTap: (index) => {
        
            widget.selectedIndexValue(index),
          
          
        },
        iconSize: 30,
        selectedFontSize: 15,
        fixedColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: widget.selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Event Home",
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units),
            label: "My Events",
          ),
          
        ],
      ),
    );
  }
}