import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var subComment = TextEditingController();

  var a = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Forums").doc().snapshots(),
        builder: (context, snapshot) {
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
                          child: CommentTreeWidget<Comment, Comment>(
                            Comment(
                                avatar: widget.listOfComments[index]
                                        .commentedUserImage ??
                                    "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f",
                                userName: widget
                                    .listOfComments[index].commentUserName,
                                content: widget
                                    .listOfComments[index].commentContent),
                            [
                              ...widget.listOfComments[index].comments.map((e) {
                                return Comment(
                                    avatar: e.commentedUserImage,
                                    userName: e.commentUserName,
                                    content: e.commentContent);
                              }),
                              Comment(
                                  avatar: FirebaseAuth
                                      .instance.currentUser!.photoURL,
                                  userName: FirebaseAuth
                                      .instance.currentUser!.displayName,
                                  content: ""),
                            ],
                            treeThemeData: TreeThemeData(
                                lineColor: Theme.of(context).primaryColor,
                                lineWidth: 3),
                            avatarRoot: (context, data) => PreferredSize(
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey,
                                child: CachedNetworkImage(
                                    placeholderFadeInDuration:
                                        const Duration(seconds: 4),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    fit: BoxFit.cover,
                                    imageUrl: widget.listOfComments[index]
                                            .commentedUserImage ??
                                        "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f"),
                              ),
                              preferredSize: const Size.fromRadius(18),
                            ),
                            avatarChild: (context, data) => PreferredSize(
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: CachedNetworkImage(
                                    placeholderFadeInDuration:
                                        const Duration(seconds: 4),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    fit: BoxFit.cover,
                                    imageUrl: data.avatar ??
                                        "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f"),
                              ),
                              preferredSize: const Size.fromRadius(12),
                            ),
                            contentChild: (context, data) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.userName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        data.content != ""
                                            ? Text(
                                                '${data.content}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black),
                                              )
                                            : TextField(
                                              toolbarOptions: const ToolbarOptions(
                          cut: true, copy: true, paste: true),
                                                controller: subComment,
                                                decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<ForumProvider>(
                                                              context,
                                                              listen: false)
                                                          .addSubComment(
                                                              widget.id,
                                                              widget
                                                                  .listOfComments[
                                                                      index]
                                                                  .commentID,
                                                              Comments(
                                                                  commentID: "",
                                                                  commentUserId:
                                                                      "",
                                                                  commentUserName:
                                                                      "",
                                                                  commentContent:
                                                                      subComment
                                                                          .text,
                                                                  commentedAt:
                                                                      DateTime
                                                                          .now()));
                                                      // setState(() {
                                                      subComment.text = "";
                                                    },
                                                    child: Icon(
                                                      Icons.send,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                )),
                                      ],
                                    ),
                                  ),
                                  DefaultTextStyle(
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: const [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text('Like'),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Text('Reply'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            contentRoot: (context, data) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.listOfComments[index]
                                              .commentUserName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${data.content}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DefaultTextStyle(
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: const [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text('Like'),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Text('Reply'),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        );
                      }),
                ),
                Positioned(
                  height: height * 0.1,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  child: TextFormField(
                    toolbarOptions: const ToolbarOptions(
                          cut: true, copy: true, paste: true),
                    controller: newComment,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          var item = Comments(
                              comments: [],
                              commentID: "",
                              commentUserId: "",
                              commentUserName: "",
                              commentContent: newComment.text,
                              commentedAt: DateTime.now());
                          Provider.of<ForumProvider>(context, listen: false)
                              .addCommentByForumId(widget.id, item);
                          newComment.text = "";
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
        });
  }
}
