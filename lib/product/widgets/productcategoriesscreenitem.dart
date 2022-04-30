import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:gamingmob/product/widgets/producthomegrid.dart';
import 'package:provider/provider.dart';

class CategoriesScreenItem extends StatelessWidget {
  const CategoriesScreenItem({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    var categoriesObject =
        Provider.of<CategoryProvider>(context, listen: false);
    var categories = categoriesObject.categories;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var favoritesProducts = Provider.of<ProductProvider>(context).favoritesOnly;
    return FutureBuilder(
          future: categoriesObject
              .fetchCategories(),
          builder: (ctx, snapshot) {
            var categires =
                Provider.of<CategoryProvider>(context, listen: false)
                    .categories;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: categires.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      return InkWell(
      onTap: () {
        var subCategories =
            categoriesObject.getSubCategories(categories[index].id);
        subCategories.isEmpty
            ? Navigator.of(context).pushNamed(
                ProductHomeScreen.routeName,
                arguments: {"category": categories[index].title},
              )
            : Navigator.of(context).pushNamed(
                ProductCategoriesDetailScreen.routeName,
                arguments: {
                  "id": categories[index].id,
                  "title": categories[index].title
                },
              );
      },
      child: Container(
        height: height * 0.2,
        width: width * 0.4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                categories[index].imageUrl,
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
            Center(
              child: Container(
                width: width * 0.5,
                color: Colors.black,
                height: 20,
                child: FittedBox(
                  child: Text(
                  categories[index].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                              ),
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
                    },
                  ),
                ),
                ProductGrid(product: favoritesProducts)
              ]);
            }
          },
        );
    
    
    
  }
}
