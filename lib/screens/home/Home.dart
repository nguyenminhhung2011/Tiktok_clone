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
  void dispose() {
    super.dispose();
  }

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

class DisPlayVideo extends StatefulWidget {
  final Video data;
  const DisPlayVideo({Key? key, required this.data}) : super(key: key);

  @override
  State<DisPlayVideo> createState() => _DisPlayVideoState();
}

class _DisPlayVideoState extends State<DisPlayVideo>
    with TickerProviderStateMixin {
  double _height = 0;
  bool _checkShowProfile = false;
  late VideoPlayerController videoController;
  late AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 10), vsync: this)
        ..repeat();
  @override
  void initState() {
    super.initState();
    setState(() {
      videoController = VideoPlayerController.network(widget.data.videoPath)
        ..initialize().then((value) {
          videoController.play();
          videoController.setVolume(1);
          videoController.setLooping(true);
        });
    });
  }

  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            child: VideoPlayer(videoController),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '@${widget.data.username}',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      fontFamily: "Muli",
                                    ),
                          ),
                          const SizedBox(height: 7),
                          ExpandableText(
                            widget.data.caption,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: "Muli",
                                    ),
                            expandText: 'show more',
                            collapseText: 'show less',
                            expandOnTextTap: true,
                            collapseOnTextTap: true,
                            maxLines: 2,
                            linkColor: Colors.blue,
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Marquee(
                                  text: widget.data.songName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: "Muli",
                                      ),
                                  velocity: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.9 - 20,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  color: Colors.red,
                                  image: DecorationImage(
                                    image: NetworkImage(widget.data.proFilePic),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15,
                                top: 39,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 250, 45, 108),
                                  ),
                                  child: Icon(Icons.add,
                                      color: Colors.white, size: 15),
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          Icon_text(
                            no: '${widget.data.likes.length}',
                            press: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                          Spacer(),
                          Icon_text(
                            no: '${widget.data.commentCount}',
                            press: () {},
                            icon: Icon(
                              Icons.comment,
                              size: 35,
                            ),
                          ),
                          Spacer(),
                          Icon_text(
                            no: '${widget.data.shareCount}',
                            press: () async {
                              await firebaseAuth.signOut();
                            },
                            icon: Icon(
                              Icons.share,
                              size: 35,
                            ),
                          ),
                          Spacer(),
                          Icon_text(
                            no: 'View',
                            press: () {
                              setState(() {
                                _height = (_height == 150) ? 0 : 150;
                                _checkShowProfile = !_checkShowProfile;
                              });
                            },
                            icon: Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                          Spacer(),
                          AnimatedBuilder(
                            animation: _controller,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 136, 199, 250),
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.data.proFilePic),
                              ),
                            ),
                            builder: (context, Widget? child) {
                              return Transform.rotate(
                                  angle: _controller.value * 2 * pi,
                                  child: child);
                            },
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                width: double.infinity,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.black,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.white10,
                    ],
                  ),
                ),
                duration: Duration(seconds: 1),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 136, 199, 250),
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.data.proFilePic),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '@${widget.data.username}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: "Muli",
                                      ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${widget.data.caption}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        fontFamily: "Muli",
                                      ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: Color.fromARGB(255, 250, 45, 108),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.favorite),
                                  const SizedBox(width: 5),
                                  Text('7,7k'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
