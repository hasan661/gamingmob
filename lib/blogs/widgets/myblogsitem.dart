import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:gamingmob/blogs/screens/blogdetailscreen.dart';
import 'package:provider/provider.dart';

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
                  return ListView.builder(
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
                                      width: width * 0.12,
                                      child: IconButton(
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
                                    ),
                                    subtitle: Text(
                                      blogItems[index]
                                          .blogCreationDate
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
                                          Image.network(
                                            blogItems[index].imageURL,
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
