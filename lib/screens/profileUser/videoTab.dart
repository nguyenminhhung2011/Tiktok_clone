import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/videoCard.dart';

class VideosTab extends StatelessWidget {
  final Map<String, dynamic> data;
  const VideosTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: data['allPosts'].length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              return VideoCard(
                data: data,
                index: index,
              );
            },
          ),
        ));
  }
}
