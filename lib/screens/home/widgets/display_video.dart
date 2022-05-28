// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/controls/video_controler.dart';
import 'package:video_player/video_player.dart';

import '../../../constains.dart';
import '../../../models/video.dart';
import '../../comment_post/comment_post.dart';
import 'icon_text.dart';

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
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.data.videoPath)
      ..initialize().then((value) {
        videoController.play();
        videoController.setVolume(0);
      });
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            child: VideoPlayer(videoController),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
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
                              const Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.9 - 20,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  color: Colors.red,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        widget.data.proFilePic),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 22,
                                top: 40,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 250, 45, 108),
                                  ),
                                  child: const Icon(Icons.add,
                                      color: Colors.white, size: 15),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Icon_text(
                            no: '${widget.data.likes.length}',
                            press: () async {
                              await VideoController().likeVideo(
                                  firebaseAuth.currentUser!.uid,
                                  widget.data.likes,
                                  widget.data.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: (widget.data.likes
                                      .contains(authMethods.user.uid))
                                  ? Colors.red
                                  : Colors.white,
                              size: 35,
                            ),
                          ),
                          const Spacer(),
                          Icon_text(
                            no: '${widget.data.commentCount}',
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentPostScreen(
                                    data: widget.data,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.comment,
                              size: 35,
                            ),
                          ),
                          const Spacer(),
                          Icon_text(
                            no: '${widget.data.shareCount}',
                            press: () async {
                              videoController.dispose();
                              await firebaseAuth.signOut();
                            },
                            icon: const Icon(
                              Icons.share,
                              size: 35,
                            ),
                          ),
                          const Spacer(),
                          Icon_text(
                            no: 'View',
                            press: () {
                              setState(() {
                                _height = (_height == 150) ? 0 : 150;
                                _checkShowProfile = !_checkShowProfile;
                              });
                            },
                            icon: const Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                          const Spacer(),
                          AnimatedBuilder(
                            animation: _controller,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
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
                          const Spacer(),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.black,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.white10,
                    ],
                  ),
                ),
                duration: const Duration(seconds: 1),
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
                                  color: const Color.fromARGB(255, 136, 199, 250),
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
                                Row(
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
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  widget.data.caption,
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
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: const Color.fromARGB(255, 250, 45, 108),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.favorite),
                                  SizedBox(width: 5),
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
