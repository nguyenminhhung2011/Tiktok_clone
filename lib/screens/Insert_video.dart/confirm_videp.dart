import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/textField_desgin.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok_clone/controls/upload_video_controller.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    Key? key,
    required this.videoPath,
    required this.videoFile,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController vidController;
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _songController = TextEditingController();
  bool is_upload = false;
  bool is_filter = false;
  double _height = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      if (kIsWeb) {
        vidController = VideoPlayerController.network(widget.videoPath)
          ..initialize().then((_) {
            vidController.play();
            vidController.setVolume(0);
            vidController.setLooping(true);
            setState(() {});
          });
      } else {
        vidController = VideoPlayerController.file(widget.videoFile);
      }
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: vidController.value.size.width,
              child: VideoPlayer(vidController),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  setState(() {
                    if (is_filter == false) {
                      is_upload = false;
                      is_filter = true;
                    } else {
                      is_filter = false;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 136, 199, 250),
                  ),
                  child: Icon(Icons.filter, size: 20),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 136, 199, 250),
                  ),
                  child: Icon(Icons.download, size: 20),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  setState(() {
                    is_upload = !is_upload;
                    _height = (is_upload) ? 200 : 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 250, 45, 108),
                  ),
                  child: Icon(Icons.upload, size: 20),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 1.2 - 160),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width,
                height: _height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      TextFieldDesgin(
                        hintText: 'Input Caption',
                        labelText: 'Caption',
                        isPass: false,
                        textController: _captionController,
                        icon: Icon(
                          Icons.closed_caption,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldDesgin(
                        hintText: 'Input Song name',
                        labelText: 'Song name',
                        isPass: false,
                        textController: _songController,
                        icon: Icon(
                          Icons.music_note,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          await upLoadVideoController().upLoadVideo(
                            _songController.text,
                            _captionController.text,
                            widget.videoPath,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 136, 199, 250),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('Upload'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
