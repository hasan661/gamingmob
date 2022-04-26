import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:provider/provider.dart';

class CategoriesScreenItem extends StatelessWidget {
  const CategoriesScreenItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    var categoriesObject =
        Provider.of<CategoryProvider>(context, listen: false);
    var categories = categoriesObject.categories;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        var subCategories =
            categoriesObject.getSubCategories(categories[index].id);
        subCategories.isEmpty
            ? Navigator.of(context).pushNamed(
                ProductHomeScreen.routeName,
                arguments: {"category":categories[index].title},
              )
            : Navigator.of(context).pushNamed(
                ProductCategoriesDetailScreen.routeName,
                arguments: {
                  "id": categories[index].id,
                  "title":categories[index].title
                },
              );
              
      },
      child: Container(
        height: height * 0.2,
        width: width * 0.4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              categories[index].imageUrl,
              fit: BoxFit.cover,
              height: 100,
            ),
            Center(
              child: Text(
                categories[index].title,
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
