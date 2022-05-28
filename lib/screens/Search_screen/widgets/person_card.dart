import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../../models/user.dart';

class PerSonCard extends StatelessWidget {
  final User data;
  const PerSonCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarCircle(avtPath: data.photoUrl, sizeAvt: 60),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.username,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Muli",
                  fontSize: 15,
                ),
              ),
              Text(
                '#${data.bio}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Muli",
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: const Color.fromARGB(255, 250, 45, 108),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite),
                const SizedBox(width: 5),
                Text('${data.followers.length}k'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
