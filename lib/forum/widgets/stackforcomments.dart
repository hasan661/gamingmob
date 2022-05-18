import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/forum/models/forum.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:provider/provider.dart';

class StackForComments extends StatefulWidget {
  const StackForComments(
      {Key? key, required this.listOfComments, required this.id})
      : super(key: key);
  final List<Comments> listOfComments;
  final String id;

  @override
  State<StackForComments> createState() => _StackForCommentsState();
}

class _StackForCommentsState extends State<StackForComments> {
  var newComment = TextEditingController();

  var a = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<ForumProvider>(
      builder: ((context, value, child) {
        return SizedBox(
          height: height,
          child: Stack(
            children: [
              SizedBox(
                height: height * 0.83,
                child: ListView.builder(
                    itemCount: widget.listOfComments.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        padding: const EdgeInsetsDirectional.only(
                            start: 50, end: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width * 0.9,
                              child: Card(
                                child: ListTile(
                                  leading: const CircleAvatar(),
                                  title: RichText(
                                    // softWrap: true,
                                    text: TextSpan(
                                        text: widget.listOfComments[index]
                                            .commentUserName,
                                        style: const TextStyle(
                                            // fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text: " " +
                                                widget.listOfComments[index]
                                                    .commentContent,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${DateTime.now().difference(widget.listOfComments[index].commentedAt).inMinutes} minutes ago"),
                                  const Text("Like"),
                                  const Text("Reply"),
                                ],
                              ),
                            ),
                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: widget
                            //             .listOfComments[index].comments.length +
                            //         1,
                            //     itemBuilder: (ctx, index2) {
                            //       if (index2 ==
                            //           widget.listOfComments[index].comments
                            //               .length) {
                                            
                            //         return SizedBox(
                            //          width: width * 0.6,
                            //           child: Card(
                            //             child: ListTile(
                            //               leading: const CircleAvatar(),
                            //               title: Row(

                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                     crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     FirebaseAuth
                            //                             .instance
                            //                             .currentUser!
                            //                             .displayName ??
                            //                         "",
                            //                     style: const TextStyle(
                            //                       // fontSize: 13,
                            //                       color: Colors.black,
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                                             
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       }
                            //      else{
                            //         return Column(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           SizedBox(
                            //             width: width * 0.6,
                            //             child: Card(
                            //               child: ListTile(
                            //                 leading: const CircleAvatar(),
                            //                 title: RichText(
                            //                   // softWrap: true,
                            //                   text: TextSpan(
                            //                       text: widget
                            //                           .listOfComments[index]
                            //                           .comments[index2]
                            //                           .commentUserName,
                            //                       style: const TextStyle(
                            //                           fontSize: 13,
                            //                           color: Colors.black,
                            //                           fontWeight:
                            //                               FontWeight.bold),
                            //                       children: [
                            //                         TextSpan(
                            //                           text: widget
                            //                               .listOfComments[index]
                            //                               .comments[index2]
                            //                               .commentContent,
                            //                           style: const TextStyle(
                            //                             fontWeight:
                            //                                 FontWeight.normal,
                            //                           ),
                            //                         )
                            //                       ]),
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: width * 0.6,
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(
                            //                     "${DateTime.now().difference(widget.listOfComments[index].comments[index2].commentedAt).inMinutes} minutes ago"),
                            //                 const Text("Like"),
                            //                 const Text("Reply"),
                            //               ],
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: height * 0.02,
                            //           ),
                            //         ],
                            //       );
                            //      }
                            //     })
                          ],
                        ),
                      );
                    }),
              ),
              Positioned(
                height: height * 0.1,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: TextFormField(
                  controller: newComment,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        var item = Comments(
                            commentID: "",
                            commentUserId: "",
                            commentUserName: "",
                            commentContent: newComment.text,
                            commentedAt: DateTime.now());
                        Provider.of<ForumProvider>(context, listen: false)
                            .addCommentByForumId(widget.id, item);
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              Positioned(
                  height: height * 0.05,
                  right: 10,
                  top: MediaQuery.of(context).viewInsets.top,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.cancel))),
            ],
          ),
        );
      }),
    );
  }
}
