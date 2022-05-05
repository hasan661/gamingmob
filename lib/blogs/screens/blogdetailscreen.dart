import 'package:flutter/material.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:provider/provider.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  static const routeName = "/blog-detail-screen";

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as String;
    var blog = Provider.of<BlogProvider>(context, listen: false).getById(id);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Detail Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
        
            Text(
              blog.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(
              height: height * 0.02,
            ),
            ...blog.blogContent.content.map((e) {
              
             
              if(e["type"]=="image"){
                return Column(
                  children: [Image.network(e["data"].toString()), SizedBox(height: height*0.02,)],
                );
              }
              else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e["data"].toString(), maxLines: null,),
                    SizedBox(height: height*0.02,)
                  ],
                );
              }
            } )
            
          ],
        ),
      ),
    );
  }
}
