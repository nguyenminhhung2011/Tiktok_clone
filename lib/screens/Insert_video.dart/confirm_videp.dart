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
  final double _height = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      if (kIsWeb) {
        vidController = VideoPlayerController.network(widget.videoPath)
          ..initialize().then((_) {
            vidController.play();
            vidController.setVolume(1);
            vidController.setLooping(true);
            setState(() {});
          });
      } else {
        vidController = VideoPlayerController.file(widget.videoFile)
          ..initialize().then((_) {
            vidController.play();
            vidController.setVolume(1);
            vidController.setLooping(true);
            setState(() {});
          });
      }
    });
  }

  void upLoadVideo(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await upLoadVideoController().upLoadVideo(
      _songController.text,
      _captionController.text,
      widget.videoPath,
      widget.videoFile,
    );
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    vidController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Spacer(),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 136, 199, 250),
                  ),
                  child: const Icon(Icons.filter, size: 20),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 136, 199, 250),
                  ),
                  child: const Icon(Icons.download, size: 20),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                                icon: const Icon(
                                  Icons.closed_caption,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFieldDesgin(
                                hintText: 'Input Song name',
                                labelText: 'Song name',
                                isPass: false,
                                textController: _songController,
                                icon: const Icon(
                                  Icons.music_note,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  upLoadVideo(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 136, 199, 250),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: (!isLoading)
                                      ? const Text('Upload')
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 250, 45, 108),
                  ),
                  child: const Icon(Icons.upload, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.yellow,
                  child: VideoPlayer(vidController),
                  height: MediaQuery.of(context).size.height,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
