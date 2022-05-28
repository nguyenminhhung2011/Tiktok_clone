import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../widgets/Avtar_circle.dart';

class PerSonCardAddGroup extends StatelessWidget {
  final User data;
  final Function() press;
  const PerSonCardAddGroup({
    Key? key,
    required this.data,
    required this.press,
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
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.black),
            onPressed: press,
          )
        ],
      ),
    );
  }
}
