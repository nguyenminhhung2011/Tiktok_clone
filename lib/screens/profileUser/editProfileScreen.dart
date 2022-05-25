import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';
import 'package:tiktok_clone/widgets/textField_desgin.dart';

import '../../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarCircle(
                avtPath: widget.user['profilePic'],
                sizeAvt: 150,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 32, 211, 234),
              ),
              child: Column(
                children: [
                  TextFieldDesgin1(
                    hintText: 'Input new username',
                    labelText: 'Username',
                    isPass: false,
                    textController: _usernameController,
                    icon: Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                  TextFieldDesgin1(
                    hintText: 'Input new Bio',
                    labelText: 'Bio',
                    isPass: false,
                    textController: _usernameController,
                    icon: Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
