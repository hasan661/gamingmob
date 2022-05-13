import 'package:flutter/material.dart';
class ForumBottomAppBar extends StatelessWidget {
  const ForumBottomAppBar({ Key? key , required this.screens, required this.selectedIndex, required this.selectedIndexValue}) : super(key: key);
  final List<Widget> screens;
  final void Function(int) selectedIndexValue;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(
          0xff8d1ba5,
        ),
      ),
      child: BottomNavigationBar(
        onTap: (value) {
          selectedIndexValue(value);
        },
      
        iconSize: 30,
        selectedFontSize: 15,
        fixedColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Forum Home",
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "My Forums",
          ),
          
        ],
      ),
    );
  }
}