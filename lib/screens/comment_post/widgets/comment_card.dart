import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/controls/comments_controller.dart';

import '../../../constains.dart';
import '../../../models/comment.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.data,
    required this.press,
  }) : super(key: key);

  final Comments data;
  final Function() press;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Map<String, dynamic> userCmt = {};
  bool checkLoad = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    setState(() {
      checkLoad = true;
    });
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(widget.data.uid).get();
    setState(() {
      userCmt = userDoc.data() as Map<String, dynamic>;
      checkLoad = false;
    });
  }

  Widget build(BuildContext context) {
    return (!checkLoad)
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            child: Card(
              color: Color.fromARGB(255, 255, 252, 227),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 250, 45, 108),
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userCmt['photoUrl']),
                        radius: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userCmt['username'],
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 32, 211, 234),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2.25 -
                                        userCmt['username'].length * 2,
                                child: Text(
                                  widget.data.title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMd()
                                    .format(widget.data.datePublished.toDate()),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${widget.data.likes.length} likes',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        CommentsController().likesCmt(
                          userCmt['uid'],
                          widget.data.postId,
                          widget.data.commentId,
                          widget.data.likes,
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: (widget.data.likes.contains(userCmt['uid']))
                            ? Color.fromARGB(255, 250, 45, 108)
                            : const Color.fromARGB(255, 32, 211, 234),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator(color: Colors.white));
  }
}
