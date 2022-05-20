import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/controls/notiController.dart';
import 'package:tiktok_clone/screens/Notification/addGroupScreen.dart';
import 'package:tiktok_clone/screens/Notification/messChat.dart';
import 'package:tiktok_clone/screens/Notification/widget/messageCard.dart';
import 'package:tiktok_clone/screens/Notification/widget/messageGroupCard.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../models/user.dart';

class NotifiCationScreen extends StatefulWidget {
  const NotifiCationScreen({Key? key}) : super(key: key);

  @override
  State<NotifiCationScreen> createState() => _NotifiCationScreenState();
}

class _NotifiCationScreenState extends State<NotifiCationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameGroup = TextEditingController();
  final NotiController _notiController = Get.put(NotiController());
  bool checkNotifi = false;
  bool checkPersonGroup = true;
  List<Map<String, dynamic>> _listUserToAddGroup = [];
  @override
  void initState() {
    super.initState();
    _notiController.updateMessage(authMethods.user.uid);
    _notiController.updateGroupMessage(authMethods.user.uid);
    _notiController.getAllUser();
  }

  void removeUserInAllUser(String uid, String username) async {
    setState(() {
      _notiController.removeUserInAllUser(uid);
      _listUserToAddGroup.add({'uid': uid, 'username': username});
    });
  }

  void removeUserInListUserToAdd(String uid, String username) async {
    setState(() {
      _notiController.addUserInAllUser(uid);
      _listUserToAddGroup.removeWhere((element) {
        return (element['uid'] == uid && element['username'] == username);
      });
    });
  }

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: (!checkNotifi)
              ? MediaQuery.of(context).size.height / 4
              : MediaQuery.of(context).size.height / 6,
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CheckNoti(context),
              const SizedBox(height: 10),
              !(checkNotifi)
                  ? Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 153, 231, 255),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.white),
                              const SizedBox(width: 2),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (_) {
                                    setState(() {
                                      _notiController.searchWithType(
                                          _searchController.text);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              !(checkNotifi)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 3),
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 252, 227),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (checkPersonGroup == false) {
                                    setState(() {
                                      checkPersonGroup = true;
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 71,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: (checkPersonGroup)
                                        ? Color.fromARGB(255, 250, 45, 108)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    'Person',
                                    style: TextStyle(
                                      color: (checkPersonGroup)
                                          ? Colors.white
                                          : Color.fromARGB(255, 250, 45, 108),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                onTap: () {
                                  if (checkPersonGroup == true) {
                                    setState(() {
                                      checkPersonGroup = false;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 71,
                                  height: 34,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: (!checkPersonGroup)
                                        ? Color.fromARGB(255, 32, 211, 234)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Group',
                                    style: TextStyle(
                                      color: (!checkPersonGroup)
                                          ? Colors.white
                                          : Color.fromARGB(255, 32, 211, 234),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        if (!checkPersonGroup)
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateGroupScreen()),
                              );
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Color.fromARGB(255, 32, 211, 234),
                            ),
                          )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
        body: (!checkNotifi)
            ? (checkPersonGroup)
                ? (_searchController.text != "")
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            children: _notiController.listUser.map((e) {
                          return PersonCard(
                            data: e,
                            press: () {
                              _notiController.creatMessageWithPerson(e.uid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessChat(
                                    uidPerson1: authMethods.user.uid,
                                    uidPerson2: e.uid,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList()),
                      )
                    : (_notiController.listMessage.isNotEmpty)
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: _notiController.listMessage
                                  .map(
                                    (e) => MessageCard(
                                      message: e,
                                      index: 1 -
                                          _notiController.getIndexUserInList(
                                            authMethods.user.uid,
                                            e.listUid,
                                          ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                Text(
                                  'You Don\t have Message',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Please search and start chat with Your friend',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: _notiController.listGroupMessage
                          .map((e) => MessageGroupCard(data: e))
                          .toList(),
                    ),
                  )
            : Container(),
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
                  _searchController.clear();
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

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.data,
    required this.press,
  }) : super(key: key);
  final User data;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Row(
        children: [
          AvatarCircle(
            avtPath: data.photoUrl,
            sizeAvt: 70,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.username,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Text(
                '#${data.bio}',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: press,
            icon: Icon(
              Icons.send,
              color: Color.fromARGB(255, 32, 211, 234),
            ),
          )
        ],
      ),
    );
  }
}
