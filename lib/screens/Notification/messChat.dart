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
      backgroundColor: Colors.white,
    );
  }
}
