import 'package:flutter/material.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:gamingmob/forum/screens/addforumscreen.dart';
import 'package:provider/provider.dart';

class ForumHomeItem extends StatelessWidget {
  const ForumHomeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return FutureBuilder(
      future: Provider.of<ForumProvider>(context,listen: false).fetchForums(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
          
        }
       else{
          var listofForums =
        Provider.of<ForumProvider>(context,).forums;
        return Column(
          children: [
            Container(
              // padding: const EdgeInsets.all(4),
              margin:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),

              child: ListTile(
                leading: const CircleAvatar(),
                title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddForumScreen.routeName);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("What is on your mind?"),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listofForums.length,
                  itemBuilder: (ctx, index) {
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(listofForums[
                                                        index]
                                                    .userImageUrl ??
                                                "https://firebasestorage.googleapis.com/v0/b/gaming-mob.appspot.com/o/GamingMob%2FNoImage.png?alt=media&token=59a0d10a-0d32-4a96-ae4f-f06f359f566f"),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: Text.rich(TextSpan(
                                                text: listofForums[index].userName +
                                                    "\n",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${DateTime.now().difference(listofForums[index].createdAt).inMinutes} minutes ago",
                                                  )
                                                ])),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.more_horiz,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    listofForums[index].forumText,
                                    maxLines: 6,
                                  ),
                                ),
                                if (listofForums[index].imageURL != null)
                                  Image.network(
                                    listofForums[index].imageURL ?? "",
                                    fit: BoxFit.fitWidth,
                                    height: 220,
                                    width: width,
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.favorite_outline),
                                        Center(
                                          child: Text.rich(TextSpan(
                                              text:
                                                  "${listofForums[index].likeList.length}\n",
                                              children: const [
                                                TextSpan(text: "Likes")
                                              ])),
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 2,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          const Icon(Icons.comment_outlined),
                                          Text.rich(TextSpan(
                                              text:
                                                  "${listofForums[index].comments.length}\n",
                                              children: const [
                                                TextSpan(text: "Comments")
                                              ])),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 3,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
       }
      }
    );
  }
}
