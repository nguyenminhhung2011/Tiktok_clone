import 'package:flutter/material.dart';

import '../../models/video.dart';

class CommentPostScreen extends StatelessWidget {
  final Video data;
  const CommentPostScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(data.proFilePic),
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
                onPressed: () {},
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
                child: Column(
                  children: [
                    CommentCard(data: data),
                    CommentCard(data: data),
                    CommentCard(data: data),
                    CommentCard(data: data),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Video data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: Card(
        color: Color.fromARGB(255, 255, 252, 227),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  backgroundImage: NetworkImage(data.proFilePic),
                  radius: 35,
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
                          'Username',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 32, 211, 234),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.25,
                          child: Text(
                            'This is comments',
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
                          '20 Nov 2002',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '7,7k likes',
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
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 250, 45, 108),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
