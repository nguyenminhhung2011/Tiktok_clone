import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/Notification/widget/memberIngroup.dart';

import '../../../models/message.dart';
import '../../../widgets/Avtar_circle.dart';
import '../messGroupChat.dart';

class MessageGroupCard extends StatelessWidget {
  final Message data;
  const MessageGroupCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessGroupScreen(data: data),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 255, 252, 227),
        ),
        child: Row(
          children: [
            AvatarCircle(
              avtPath: data.photoGroup_member,
              sizeAvt: 70,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nameOfGroup,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  '${data.listUid.length} members in group chat',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 10),
                    Text(
                      '9:00 PM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 80,
                  height: 30,
                  child: Stack(
                    children: [
                      MemberInGroup(
                        photoPath: data.photoUrl[0],
                      ),
                      Positioned(
                        left: 20,
                        child: MemberInGroup(
                          photoPath: data.photoUrl[1],
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: MemberInGroup(
                          photoPath: data.photoUrl[2],
                        ),
                      )
                    ],
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
