import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/categories.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:provider/provider.dart';

class CategoriesDetailScreenItem extends StatelessWidget {
  const CategoriesDetailScreenItem({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var categoriesObject =
        Provider.of<CategoryProvider>(context, listen: false);
    List<SubCategories> listOfSubcategories =
        categoriesObject.getSubCategories(id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: listOfSubcategories.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductHomeScreen.routeName,
                  arguments: {
                    "subcategory": listOfSubcategories[index].title,
                    "category": title
                  });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  CachedNetworkImage(
                    placeholderFadeInDuration: const Duration(seconds: 4),
                            placeholder: (context, url)=>const Center(child: CircularProgressIndicator()),
                    imageUrl: listOfSubcategories[index].imageUrl,
                    fit: BoxFit.cover,
                    height: 100,
                    width: width*0.5,
                  ),
                  Container(
                    height: 20,
                    color: Colors.black,
                    child: Center(
                child: Text(
                    listOfSubcategories[index].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                ),
              ),
                  ),
                ],
              ),
            ),
          );
          
        },
      ),
    );
  }
}
