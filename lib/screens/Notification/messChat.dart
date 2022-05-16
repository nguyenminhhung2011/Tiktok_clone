import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../controls/messController.dart';

class MessChat extends StatefulWidget {
  final String uidPerson1; //uid
  final String uidPerson2; //op Uid
  const MessChat({
    Key? key,
    required this.uidPerson1,
    required this.uidPerson2,
  }) : super(key: key);

  @override
  State<MessChat> createState() => _MessChatState();
}

class _MessChatState extends State<MessChat> {
  final MessController _messController = Get.put(MessController());
  final TextEditingController _stringController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _messController.updateMessWithPerson(widget.uidPerson1, widget.uidPerson2);
    _messController.updateUserAndOpUser(widget.uidPerson1, widget.uidPerson2);
  }

  void sendMessage() async {
    await _messController.sendMessage(
        _stringController.text, 0, widget.uidPerson2);
    setState(() {
      _stringController.clear();
    });
  }

  Widget build(BuildContext context) {
    return Obx(
      () => (_messController.user.isNotEmpty &&
              _messController.opUser.isNotEmpty)
          ? Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: const Color.fromARGB(255, 32, 211, 234),
                    ),
                  )
                ],
                toolbarHeight: MediaQuery.of(context).size.height * 0.08,
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
                    AvatarCircle(
                      avtPath: _messController.opUser['photoUrl'],
                      sizeAvt: 60,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _messController.opUser['username'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '#${_messController.opUser['bio']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(-2, -2),
                      blurRadius: 100,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 32, 211, 234),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _stringController,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Send Message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.mic,
                                  color:
                                      const Color.fromARGB(255, 32, 211, 234),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color:
                                      const Color.fromARGB(255, 32, 211, 234),
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.gif_box_outlined,
                                  color:
                                      const Color.fromARGB(255, 32, 211, 234),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(
                          Icons.send,
                          color: const Color.fromARGB(255, 32, 211, 234),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AvatarCircle(
                            avtPath: _messController.opUser['photoUrl'],
                            sizeAvt: 90,
                          ),
                          Text(
                            _messController.opUser['username'],
                            style: TextStyle(
                              color: const Color.fromARGB(255, 32, 211, 234),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            _messController.opUser['bio'],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_messController.opUser['following'].length} Following | ${_messController.opUser['followers'].length} followers',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Align(
                            alignment: Alignment.centerRight,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
