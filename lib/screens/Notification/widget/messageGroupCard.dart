import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/Notification/widget/memberIngroup.dart';

import '../../../widgets/Avtar_circle.dart';

class MessageGroupCard extends StatelessWidget {
  const MessageGroupCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 255, 252, 227),
      ),
      child: Row(
        children: [
          AvatarCircle(
            avtPath:
                'https://i.pinimg.com/originals/46/cb/f6/46cbf63a8a09b08170778befb024c4fc.jpg',
            sizeAvt: 70,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name group chat',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Text(
                '2 members in group chat',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    '9:00 PM',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                width: 80,
                height: 30,
                child: Stack(
                  children: [
                    MemberInGroup(
                      photoPath:
                          'https://i.pinimg.com/originals/46/cb/f6/46cbf63a8a09b08170778befb024c4fc.jpg',
                    ),
                    Positioned(
                      left: 20,
                      child: MemberInGroup(
                        photoPath:
                            'https://media-cdn-v2.laodong.vn/storage/newsportal/2021/10/8/961484/Rose-Blackpink.jpg',
                      ),
                    ),
                    Positioned(
                      left: 40,
                      child: MemberInGroup(
                        photoPath:
                            'https://thuthuatnhanh.com/wp-content/uploads/2021/06/Hinh-anh-Rose-Black-Pink-1.jpg',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
