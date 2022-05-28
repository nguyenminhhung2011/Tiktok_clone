import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/settingController.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../controls/fake_data.dart';

class SettingScreen extends StatefulWidget {
  final List<String> listMess;
  final Map<String, dynamic> userOP;
  final int typeOfMess;
  const SettingScreen({
    Key? key,
    required this.listMess,
    required this.userOP,
    required this.typeOfMess,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingControllers _settingController = Get.put(SettingControllers());
  String imagePath =
      "https://tkwebgiare.com/sites/default/files/2021-01/go%20lang.jpg";
  @override
  void initState() {
    super.initState();
    if (widget.typeOfMess == 1) {
      _settingController.getAllMemberInGroup(widget.userOP['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 32, 211, 234),
            ),
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        // elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (widget.typeOfMess == 0)
                  ? AvatarCircle(
                      avtPath: widget.userOP['photoUrl'], sizeAvt: 170)
                  : AvatarCircle(
                      avtPath: widget.userOP['photoGroup_member'],
                      sizeAvt: 170),
            ],
          ),
          (widget.typeOfMess == 0)
              ? Text(
                  widget.userOP['username'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
              : Text(
                  widget.userOP['nameOfGroup'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 252, 227),
                ),
                child: const Icon(
                  Icons.phone,
                  color: Color.fromARGB(255, 32, 211, 234),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  if (widget.typeOfMess == 1) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                children: _settingController.listMemberInGroup
                                    .map((e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    AvatarCircle(
                                        avtPath: e['photoPath'], sizeAvt: 60),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e['username'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            // fontFamily: "Muli",
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '#${e['bio']}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            // fontFamily: "Muli",
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.person, color: Colors.black),
                                  ],
                                ),
                              );
                            }).toList()),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 255, 252, 227),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 32, 211, 234),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 252, 227),
                ),
                child: const Icon(
                  Icons.picture_as_pdf,
                  color: Color.fromARGB(255, 32, 211, 234),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 255, 252, 227),
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 2,
                        childAspectRatio: 4.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (widget.typeOfMess == 0) {
                              _settingController.updateColorOfChat(
                                widget.userOP['uid'],
                                FakeData().color_mess[index]['index'],
                                0,
                              );
                            } else {
                              _settingController.updateColorOfChat(
                                widget.userOP['id'],
                                FakeData().color_mess[index]['index'],
                                1,
                              );
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: FakeData().color_mess[index]['color'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 32, 211, 234),
              ),
              child: Row(
                children: [
                  const Text(
                    'Change Collor of Message',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 250, 45, 108),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 32, 211, 234),
              ),
              child: Row(
                children: [
                  const Text(
                    'Change NickName',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          (widget.listMess.isNotEmpty)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 252, 227),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width - 20,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              imagePath,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: widget.listMess.map((e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    imagePath = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(e),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
