import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/widgets/addblogsitem.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);
  static const routeName = "/addblogs";

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blogs"),
        centerTitle: true,
      ),
      body: const AddBlogsItem(),
    );
  }
}
