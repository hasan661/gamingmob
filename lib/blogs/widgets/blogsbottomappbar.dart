import 'package:flutter/material.dart';
class BlogsBottomAppBar extends StatefulWidget {
  const BlogsBottomAppBar({ Key? key, required this.screens, required this.selectedIndex, required this.selectedIndexValue }) : super(key: key);
  final List<Widget> screens;
  final void Function(int) selectedIndexValue;
  final int selectedIndex;

  @override
  State<BlogsBottomAppBar> createState() => _BlogsBottomAppBarState();
}

class _BlogsBottomAppBarState extends State<BlogsBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(
          0xff8d1ba5,
        ),
      ),
      child: BottomNavigationBar(
        onTap: (index) => {widget.selectedIndexValue(index)},
        iconSize: 30,
        selectedFontSize: 15,
        fixedColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: widget.selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "My Blogs",
          ),
          
        ],
      ),
    );
  }
}