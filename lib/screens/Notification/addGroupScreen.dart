import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/controls/addGroupController.dart';
import 'package:tiktok_clone/screens/Notification/widget/personCardToAddGroup.dart';

import '../../models/user.dart';
import '../../utils/untils.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final AddGroupController _addGroupController = Get.put(AddGroupController());
  List<User> _listUserToAddGroup = [];
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    _addGroupController.getAllUser();
  }

  void addUserToGroup(User e) async {
    await _addGroupController.removeUserController(e.uid);
    _listUserToAddGroup.add(e);
    setState(() {});
  }

  void removeUserToGroup(User e) async {
    await _addGroupController.addUserController(e);
    _listUserToAddGroup.removeWhere((element) => e.uid == element.uid);
    setState(() {});
  }

  void selectedImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text(
            'Create Group',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 32, 211, 231),
                ),
              ),
              child: TextFormField(
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Name of Group',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 252, 227),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _listUserToAddGroup
                      .map((e) => UserCardToAddGroup(
                          uid: e.uid,
                          username: e.username,
                          press: () {
                            removeUserToGroup(e);
                          }))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 252, 227),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: _addGroupController.allUser
                        .map(
                          (e) => PerSonCardAddGroup(
                            data: e,
                            press: () {
                              addUserToGroup(e);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 94, 153, 201),
                    ),
                  ),
                  child: (_image == null)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i0.wp.com/phocode.com/wp-content/uploads/2016/08/golang.sh-600x600.png?fit=300%2C300&ssl=1'),
                          radius: 45,
                        )
                      : CircleAvatar(
                          radius: 45,
                          backgroundImage: MemoryImage(_image!),
                        ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your Image of Group',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        selectedImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 94, 153, 201),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.camera),
                            const SizedBox(width: 5),
                            Text('Pick Image'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 100,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 211, 231),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Creata Group',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class UserCardToAddGroup extends StatelessWidget {
  final String uid;
  final String username;
  final Function() press;
  const UserCardToAddGroup({
    Key? key,
    required this.uid,
    required this.username,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 211, 231),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 2),
          InkWell(onTap: press, child: Icon(Icons.close, size: 12)),
        ],
      ),
    );
  }
}
