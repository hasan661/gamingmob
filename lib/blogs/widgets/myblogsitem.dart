import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:gamingmob/blogs/screens/addblogsscreen.dart';
import 'package:gamingmob/blogs/screens/blogdetailscreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyBlogsScreen extends StatefulWidget {
  const MyBlogsScreen({Key? key}) : super(key: key);

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Blogs").snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder(
              future: Provider.of<BlogProvider>(context).fetchBlogs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var blogItems =
                      Provider.of<BlogProvider>(context).getListById();
                  if(blogItems.isEmpty){
                    return const Center(child: Text("No Blogs Yet", style: TextStyle(color: Colors.black),),);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                BlogDetailScreen.routeName,
                                arguments: blogItems[index].id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 5,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Card(
                              elevation: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    title: Text(
                                      blogItems[index].userName,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    trailing: SizedBox(
                                      width: width * 0.24,
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: (){
                                            Navigator.of(context).pushNamed(AddBlogScreen.routeName,arguments: blogItems[index].id);
                                          }, icon: const Icon(Icons.edit)),
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<BlogProvider>(context,
                                                      listen: false)
                                                  .removeABlog(blogItems[index].id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Theme.of(context).errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat("dd MM yy At hh:mm"
                                             ).format( blogItems[index].blogCreationDate)
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.02,
                                      right: width * 0.02,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:blogItems[index].imageURL!="" && blogItems[index].imageURL!="null"?blogItems[index].imageURL:"https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2Fno-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg?alt=media&token=744697d4-20e2-4bf2-9046-c5a83c6f6859",
                                            fit: BoxFit.cover,
                                            // height: 100,
                                          ),
                                          Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            height: height * 0.06,
                                            width: width,
                                            child: Center(
                                              child: Text(
                                                blogItems[index].title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        });
  }
}
