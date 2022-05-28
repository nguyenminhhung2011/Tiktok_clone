import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';
import 'package:video_player/video_player.dart';

import '../../../models/video.dart';

class DisPlayVideo extends StatefulWidget {
  final Size size;
  final Video video;
  const DisPlayVideo({
    Key? key,
    required this.size,
    required this.video,
  }) : super(key: key);

  @override
  State<DisPlayVideo> createState() => _DisPlayVideoState();
}

class _DisPlayVideoState extends State<DisPlayVideo> {
  late VideoPlayerController videoController;
  bool playVideo = true;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.video.videoPath)
      ..initialize().then((value) {
        videoController.play();
        videoController.setVolume(0);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: widget.size.height / 1.4 - 10,
      width: widget.size.width / 1.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: VideoPlayer(videoController),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (playVideo == true) {
                          videoController.pause();
                        } else {
                          videoController.play();
                        }
                        playVideo = !playVideo;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 252, 227),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Color.fromARGB(255, 250, 45, 108),
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const InkWell(
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.video.caption,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.music_note,
                            size: 15,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.video.songName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 32, 211, 234),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.video.thumbNailsPath),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.favorite, color: Colors.white),
                      Text(
                        '${widget.video.likes.length},0 K',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const Icon(Icons.message, color: Colors.white),
                      Text(
                        '${widget.video.commentCount},0 K',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const Icon(Icons.share, color: Colors.white),
                      Text(
                        '${widget.video.shareCount},0 K',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                height: widget.size.height / 7,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.black26,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    AvatarCircle(
                      avtPath: widget.video.proFilePic,
                      sizeAvt: 80,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.video.username,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '#${widget.video.caption}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 250, 45, 108),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.white),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.video.likes.length},0 K',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
