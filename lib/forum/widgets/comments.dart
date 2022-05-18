import 'package:flutter/material.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:gamingmob/forum/widgets/stackforcomments.dart';
import 'package:provider/provider.dart';
class Comments{
 
  morecomments(context, width, id){
     var height=MediaQuery.of(context).size.height;
      var comments=Provider.of<ForumProvider>(context, listen: false).getCommentsById(id);

    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: height*0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) => StackForComments(listOfComments: comments,id:id));
  }

}
