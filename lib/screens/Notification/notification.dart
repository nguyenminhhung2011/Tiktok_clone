import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

class NotifiCationScreen extends StatefulWidget {
  const NotifiCationScreen({Key? key}) : super(key: key);

  @override
  State<NotifiCationScreen> createState() => _NotifiCationScreenState();
}

class _NotifiCationScreenState extends State<NotifiCationScreen> {
  bool checkNotifi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 6,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  'All Acitivities',
                  // ignore: deprecated_member_use
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Muli",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CheckNoti(context)
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MessageCard(),
            MessageCard(),
            MessageCard(),
            MessageCard(),
            MessageCard(),
          ],
        ),
      ),
    );
  }

  Container CheckNoti(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 60,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (checkNotifi == false) {
                    checkNotifi = true;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: checkNotifi ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Notification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (checkNotifi == true) {
                    checkNotifi = false;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: !checkNotifi ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Message',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
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
        color: Color.fromARGB(255, 230, 251, 255),
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
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your bio',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '9:00 PM',
                    style: TextStyle(color: Colors.grey),
                  ),
                  // const SizedBox(width: 2),
                  // Container(
                  //   height: 8,
                  //   width: 8,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
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
    );
  }
}
