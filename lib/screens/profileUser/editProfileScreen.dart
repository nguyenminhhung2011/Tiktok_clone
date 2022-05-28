import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/controls/profile_controllers.dart';

import '../../controls/editProfileController.dart';
import '../../utils/untils.dart';

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
  final TextEditingController _bioController = TextEditingController();
  final EditProfileController _editProfileController =
      Get.put(EditProfileController());
  final ProfileControls _profilController = Get.put(ProfileControls());
  Uint8List? _image;
  late String photoUrl;
  @override
  void initState() {
    super.initState();
    setState(() {
      _usernameController.text = widget.user['username'];
      _bioController.text = widget.user['bio'];
      photoUrl = widget.user['profilePic'];
    });
  }

  void selectedImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }

  void updateProfile(BuildContext context) {
    if (_usernameController.text == "" || _bioController.text == "") {
      Get.snackbar('Edit Profile', "Field not null",
          backgroundColor: Colors.blue);
    } else {
      _editProfileController.editProFile(authMethods.user.uid,
          _usernameController.text, _bioController.text, photoUrl);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _profilController.upDateUser(authMethods.user.uid);
  }

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
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
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
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: (_image != null)
                          ? (DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(_image!),
                            ))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.user['profilePic'],
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 110,
                    child: InkWell(
                      onTap: () {
                        selectedImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Icon(
                          Icons.camera,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 32, 211, 234),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 40),
                      Text(
                        "Username",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextFieldDesign(
                    textController: _usernameController,
                    icon: const Icon(Icons.person, color: Colors.blue),
                    hintText: "New username",
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 40),
                      Text(
                        "Bio",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextFieldDesign(
                    textController: _bioController,
                    icon: const Icon(Icons.tiktok, color: Colors.blue),
                    hintText: "New Bio",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      updateProfile(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 250, 45, 108),
                      ),
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldDesign extends StatelessWidget {
  final TextEditingController textController;
  final Widget icon;
  final String hintText;
  const TextFieldDesign({
    Key? key,
    required this.textController,
    required this.icon,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          icon,
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
