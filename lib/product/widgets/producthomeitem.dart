import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:gamingmob/product/screens/productdetailscreen.dart';

class ProductHomeItem extends StatelessWidget {
  const ProductHomeItem(
      {Key? key, required this.gamingProducts, required this.index})
      : super(key: key);

  final List<Product> gamingProducts;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: gamingProducts[index].productID,
          );
        },
        splashColor: Colors.purple.withOpacity(0.1),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: gamingProducts[index].imageURL[0] ,
                            placeholderFadeInDuration: const Duration(seconds: 4),
                            placeholder: (context, url)=>const Center(child: CircularProgressIndicator()),
    
                      
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  gamingProducts[index].productName,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  8,
                ),
                child: Text(
                  gamingProducts[index].productType == "Rent"
                      ? "${gamingProducts[index].productPrice} per day"
                      : "Rs " + gamingProducts[index].productPrice.toString(),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  8,
                ),
                child: Text(
                    "Product Type: ${gamingProducts[index].productType}",
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}
