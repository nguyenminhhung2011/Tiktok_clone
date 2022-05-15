import 'package:flutter/material.dart';

class MessChat extends StatelessWidget {
  final String uidPerson1;
  final String uidPerson2;
  const MessChat({
    Key? key,
    required this.uidPerson1,
    required this.uidPerson2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Row(
          children: [
            Text(
              'Comments',
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
      ),
      backgroundColor: Colors.white,
    );
  }
}
