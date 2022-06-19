import 'package:flutter/material.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:gamingmob/forum/widgets/stackforcomments.dart';
import 'package:provider/provider.dart';
class MoreComments{
 
  morecomments(context, width, id){
     var height=MediaQuery.of(context).size.height;
     

    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: height*0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) => Consumer<ForumProvider>(
          builder: (context, snapshot, _) {
             var comments=Provider.of<ForumProvider>(context).getCommentsById(id);
            return StackForComments(listOfComments: comments,id:id);
          }
        ));
  }

}
