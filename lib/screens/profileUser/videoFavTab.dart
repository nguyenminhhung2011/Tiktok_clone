import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/videoFavCard.dart';

import '../../models/video.dart';

class videoFavTab extends StatelessWidget {
  final List<Video> data;
  const videoFavTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: data.map((e) {
            return VideoFavCard(data: e);
          }).toList(),
        ),
      ),
    );
  }
}
