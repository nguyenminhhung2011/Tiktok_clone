import 'package:flutter/material.dart';

import '../../../models/video.dart';

class VideoCard extends StatelessWidget {
  final Video data;
  const VideoCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(data.thumbNailsPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            data.caption,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(data.proFilePic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                data.username,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.favorite,
                size: 18,
                color: Color.fromARGB(255, 250, 45, 108),
              ),
              const SizedBox(width: 3),
              Text(
                data.likes.length.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
