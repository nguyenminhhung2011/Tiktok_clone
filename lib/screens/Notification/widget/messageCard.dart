import 'package:flutter/material.dart';

import '../../../models/message.dart';
import '../../../widgets/Avtar_circle.dart';
import '../messChat.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);
  final Message message;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessChat(
              uidPerson1: message.listUid[1 - index],
              uidPerson2: message.listUid[index],
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 230, 251, 255),
        ),
        child: Row(
          children: [
            AvatarCircle(
              avtPath: message.photoUrl[index],
              sizeAvt: 70,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.username[index],
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  message.messNearest,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '9:00 PM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
