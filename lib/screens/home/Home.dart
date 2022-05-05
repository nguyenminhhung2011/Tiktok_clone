// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/controls/video_controler.dart';
import 'package:tiktok_clone/screens/home/widgets/display_video.dart';
import 'package:tiktok_clone/screens/home/widgets/icon_text.dart';
import 'package:video_player/video_player.dart';

import '../../constains.dart';
import '../../models/video.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isFollowing = true;
  final VideoController video_controler = Get.put(VideoController());
  // make animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.live_tv),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 136, 199, 250),
              ),
              child: Icon(Icons.search),
            ),
          ),
          SizedBox(width: 15),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              padding:
                  const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 252, 227),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 252, 227),
                    Color.fromARGB(255, 255, 252, 227),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_isFollowing == false) {
                        setState(() {
                          _isFollowing = !_isFollowing;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (_isFollowing)
                            ? Color.fromARGB(255, 136, 199, 250)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Following',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: (_isFollowing)
                              ? Colors.white
                              : Color.fromARGB(255, 136, 199, 250),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      if (_isFollowing == true) {
                        setState(() {
                          _isFollowing = !_isFollowing;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !(_isFollowing)
                            ? Color.fromARGB(255, 250, 45, 108)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: !(_isFollowing)
                              ? Colors.white
                              : Color.fromARGB(255, 250, 45, 108),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => PageView.builder(
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemCount: video_controler.listVIdeo.length,
          itemBuilder: (context, index) {
            final data = video_controler.listVIdeo[index];
            return DisPlayVideo(data: data);
          },
        ),
      ),
    );
  }
}
