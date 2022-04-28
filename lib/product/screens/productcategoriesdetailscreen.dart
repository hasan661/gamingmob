import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/categories.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/widgets/categoriesdetailscreenitem.dart';
import 'package:gamingmob/product/widgets/marketplacebottomnavbar.dart';
import 'package:provider/provider.dart';
class ProductCategoriesDetailScreen extends StatelessWidget {
  const ProductCategoriesDetailScreen({Key? key})
      : super(key: key);
  static const routeName = "/productcategoriesdetail";
  @override
  Widget build(BuildContext context) {
    var idMap=ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    String title=idMap["title"]??"";
    String id=idMap["id"] ?? "";
    var categoriesObject = Provider.of<CategoryProvider>(context, listen: false);
    List<SubCategories> listOfSubcategories=categoriesObject.getSubCategories(id);
   
    return Scaffold(
      bottomNavigationBar: const BottomNavBarMarketplace(),
      appBar: AppBar(),
      body: Padding(
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
              return CategoriesDetailScreenItem(index: index, subcategories:listOfSubcategories, title:title);
              
            },
          ),
        ),
    );
  }
}
