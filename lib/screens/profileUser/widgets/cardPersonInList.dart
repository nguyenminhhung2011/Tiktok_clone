import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../widgets/Avtar_circle.dart';

class CardPersonInList extends StatelessWidget {
  const CardPersonInList({
    Key? key,
    required this.size,
    required this.user,
    required this.press,
  }) : super(key: key);

  final Size size;
  final User user;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 4.5,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 243, 191),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarCircle(
                    avtPath: user.photoUrl, sizeAvt: size.width / 4 - 20),
                const SizedBox(height: 8),
                Text(
                  user.username,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  "#${user.bio}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: press,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    width: size.width / 4 - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 32, 211, 234),
                    ),
                    child: Text(
                      'Following',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
