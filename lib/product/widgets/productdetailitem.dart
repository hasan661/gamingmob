import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/product/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailItem extends StatefulWidget {
  const ProductDetailItem(
      {Key? key,
      required this.product,
      required this.screenWidth,
      required this.id})
      : super(key: key);

  final Product product;
  final double screenWidth;
  final String id;
  @override
  State<ProductDetailItem> createState() => _ProductDetailItemState();
}

class _ProductDetailItemState extends State<ProductDetailItem> {
  Future<void> _sendEmail(email) async {
    await launch(
      "mailto:$email",
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> _messageOwner(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    }
  }

//    Future<String> loadAsset() async {
//   return await rootBundle.loadString('assets/config.json');
// }
  var activeindex = 0;
  @override
  Widget build(BuildContext context) {
    Future<void> openwhatsapp(var phoneNumber) async {
      var whatsapp = "92$phoneNumber";
      var whatsappURlAndroid =
          "whatsapp://send?phone=" + whatsapp + "&text=hello";

      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp Not Installed")));
      }
    }

    Future<void> showURLLaunchDialog() {
      return showDialog(
          context: context,
          builder: (ctx) => SimpleDialog(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.red,
                      ),
                      title: const Text("Contact Via Email"),
                      onTap: () {
                        _sendEmail(widget.product.ownerEmail);
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/whatsapp (2).png",
                        height: 20,
                        width: 20,
                      ),
                      title: const Text("Contact Via Whatsapp"),
                      onTap: () {
                        openwhatsapp(widget.product.ownerMobileNum);
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.message,
                        color: Colors.blue,
                      ),
                      title: const Text("Contact Via Message"),
                      onTap: () {
                        _messageOwner(widget.product.ownerMobileNum);
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.blueGrey,
                      ),
                      title: const Text("Contact Via Call"),
                      onTap: () {
                        _makePhoneCall(widget.product.ownerMobileNum);
                      },
                    ),
                  )
                ],
              ));
    }

    return ListView(
      children: [
        CarouselSlider.builder(
          // carouselController: ,
          itemCount: widget.product.imageURL.length,
          itemBuilder: (ctx, index, _) {
            return CachedNetworkImage(imageUrl:
              widget.product.imageURL[index],
              width: widget.screenWidth,
               placeholderFadeInDuration: const Duration(seconds: 4),
                            placeholder: (context, url)=>const Center(child: CircularProgressIndicator()),
              fit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
            aspectRatio: 1/1,
            enableInfiniteScroll: false,
            // pageSnapping: false,
            onPageChanged: (index, reason) {
              setState(() {
                // print(index);
                activeindex = index;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeindex,
              count: widget.product.imageURL.length,
              effect: SlideEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Colors.grey,
                  activeDotColor: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.productType == "Rent"
                    ? "Rs ${widget.product.productPrice} per day"
                    : "Rs ${widget.product.productPrice}",
                style: Theme.of(context).textTheme.headline4,
              ),
              Consumer<ProductProvider>(
                builder: (context, productItem, _) => IconButton(
                  onPressed: () async{
                    
                      await productItem.toggleFavorites(widget.id);
                    
                  },
                  icon: productItem.filterbyid(widget.id).isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.product.productDescripton,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Product Type",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    widget.product.productType,
                  )
                ],
              ),
            ),
            Card(
              // elevation: 20,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.product.ownerImage??"https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f",
                    ),
                  ),
                  title: Text(
                    widget.product.ownerName,
                    style: const TextStyle(color: Colors.black),
                  ),
                  
                  trailing: SizedBox(
                    height: 30,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        showURLLaunchDialog();
                      },
                      child: const Text(
                        "Contact Owner",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          
          ],
        )
      ],
    );
  }
}
