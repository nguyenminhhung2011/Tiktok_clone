import 'package:flutter/material.dart';

import '../../../models/notification.dart';
import '../../../models/video.dart';
import '../../../widgets/Avtar_circle.dart';

class NotiLikePostComment extends StatefulWidget {
  final Noti data;
  final Function() press;
  const NotiLikePostComment({
    Key? key,
    required this.data,
    required this.press,
  }) : super(key: key);

  @override
  State<NotiLikePostComment> createState() => _NotiLikePostCommentState();
}

class _NotiLikePostCommentState extends State<NotiLikePostComment> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
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
              avtPath: widget.data.profilePic,
              sizeAvt: 70,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.username,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const Text(
                  'was like your post',
                  style: TextStyle(
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
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.white),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.data.postPath,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
