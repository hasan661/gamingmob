import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/categories.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
class CategoriesDetailScreenItem extends StatelessWidget {
  const CategoriesDetailScreenItem({ Key? key , required this.index, required this.subcategories, required this.title}) : super(key: key);
  final int index;
  final String title;
  final List<SubCategories> subcategories;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ProductHomeScreen.routeName, arguments: {"subcategory":subcategories[index].title, "category":title});
      },
      child: Container(
        height: height * 0.2,
        width: width * 0.4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              subcategories[index].imageUrl,
              fit: BoxFit.cover,
              height: 100,
            ),
            Center(
              child: Text(
                subcategories[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}