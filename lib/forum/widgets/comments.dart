import 'package:flutter/material.dart';

class Comments {
  morecomments(context, width) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsetsDirectional.only(start: 50, end: 20),
                    child: SizedBox(
                      width: width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            child: ListTile(
                              leading: const CircleAvatar(),
                              title: RichText(
                                // softWrap: true,
                                text: const TextSpan(
                                    text: "Alishba Mubeen",
                                    style: TextStyle(
                                        // fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            " This looks amazing and a good initiative to build a community. Keep it up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width - 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("2m ago"),
                                    Text("*"),
                                    Text("Appreciate"),
                                    Text("*"),
                                    Text("Reply"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  child: ListTile(
                                    leading: const CircleAvatar(),
                                    title: RichText(
                                      // softWrap: true,
                                      text: const TextSpan(
                                          text: "Alishba Mubeen",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                              text:
                                                  " This looks amazing and a good initiative to build a community. Keep it up",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: width - 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("2m ago"),
                                          Text("*"),
                                          Text("Appreciate"),
                                          Text("*"),
                                          Text("Reply"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
