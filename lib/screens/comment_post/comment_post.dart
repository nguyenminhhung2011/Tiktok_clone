import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/controls/profile_controllers.dart';
import 'package:tiktok_clone/controls/video_controler.dart';
import 'package:tiktok_clone/models/comment.dart';
import 'package:tiktok_clone/screens/comment_post/widgets/comment_card.dart';

import '../../controls/comments_controller.dart';
import '../../models/video.dart';

class CommentPostScreen extends StatefulWidget {
  final Video data;
  const CommentPostScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<CommentPostScreen> createState() => _CommentPostScreenState();
}

class _CommentPostScreenState extends State<CommentPostScreen> {
  final TextEditingController commentConttoller = TextEditingController();
  CommentsController cmtController = Get.put(CommentsController());
  @override
  void initialize() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void postComments() async {
    String res = await cmtController.PostComments(commentConttoller.text);
    if (res != "Comment is uploaded") {
      Get.snackbar('Upload comments error', res, backgroundColor: Colors.blue);
    } else {
      await VideoController().updateCmtCount(widget.data.id);
    }
  }

  Widget build(BuildContext context) {
    cmtController.upDatePostId(widget.data.id);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Row(
          children: [
            Text(
              'Comments',
              // ignore: deprecated_member_use
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Muli",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(-2, -2),
              blurRadius: 100,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.6435-9/199077180_344520240499485_2792476399852603899_n.jpg?_nc_cat=106&ccb=1-6&_nc_sid=174925&_nc_ohc=-xWqMqllrCUAX-JR9S1&_nc_oc=AQktIZvG7GEZ8hAam3eWWzOYAd4ePl6ZHqfAe4Aj34rxwp8cd2n09Me_CO7Q6pyD3Ng&_nc_ht=scontent.fsgn2-3.fna&oh=00_AT9bY3sEb8ZY5fJQdB1QEJKuFGKclTyyrLyDGBkVs8U7Gw&oe=629D6B46',
                ),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 32, 211, 234),
                    ),
                  ),
                  child: TextFormField(
                    controller: commentConttoller,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'Enter your comments',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  postComments();
                  setState(() {
                    commentConttoller.clear();
                  });
                },
                icon: Icon(
                  Icons.send,
                  color: const Color.fromARGB(255, 32, 211, 234),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.17,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => Column(
                    children: cmtController.listComments.map(
                      (e) {
                        return CommentCard(
                          data: e,
                          press: () {},
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
