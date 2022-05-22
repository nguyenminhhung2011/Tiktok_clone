import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/controls/fake_data.dart';
import 'package:tiktok_clone/screens/Notification/settingScreen.dart';
import 'package:tiktok_clone/screens/Notification/widget/recCard.dart';
import 'package:tiktok_clone/screens/Notification/widget/sendCard.dart';
import 'package:tiktok_clone/utils/untils.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../constains.dart';
import '../../controls/messController.dart';
import '../../controls/storage_methods.dart';
import '../../models/messItem.dart';

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
  Uint8List? _image;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _messController.updateMessWithPerson(widget.uidPerson1, widget.uidPerson2);
    _messController.updateUserAndOpUser(widget.uidPerson1, widget.uidPerson2);
    //_messController.upDateAllImageInMess(widget.uidPerson1, widget.uidPerson2);
  }

  void sendMessage() async {
    if (_stringController.text.length > 25) {
      var l = _stringController.text.split(' ');
      if (l.length > 2) {
        int countLength = 0;
        String addS = "";
        int check = 1;
        int count = 0;
        l.forEach(
          (element) {
            if ((countLength / 25).floor() == check && count < l.length - 1) {
              addS += '\n';
              check++;
            }
            countLength += element.length;
            addS += element + ' ';
            count++;
          },
        );
        await _messController.sendMessage(addS, 0, widget.uidPerson2);
      } else {
        await _messController.sendMessage(
            _stringController.text, 0, widget.uidPerson2);
      }
    } else {
      await _messController.sendMessage(
          _stringController.text, 0, widget.uidPerson2);
    }

    setState(() {
      _stringController.clear();
    });
  }

  void sendImage(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    String photoUrl =
        await StorageMethods().UploadImageStorage('MessagePics', _image!, true);
    await _messController.sendMessage(photoUrl, 1, widget.uidPerson2);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  void sendEmoji(BuildContext context, String emoji_path) async {
    _messController.sendMessage(emoji_path, 2, widget.uidPerson2);
    Navigator.pop(context);
  }

  void selectedImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 252, 227),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(_image!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        sendImage(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: FakeData().color_mess[
                              _messController.message['colorOfchat']]['color'],
                        ),
                      ),
                    )
                  ],
                ),
                (isLoading)
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
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
                      color: FakeData().color_mess[
                          _messController.message['colorOfchat']]['color'],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(
                            listMess: _messController.allImageInMess,
                            userOP: _messController.opUser,
                            typeOfMess: 0,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: FakeData().color_mess[
                          _messController.message['colorOfchat']]['color'],
                    ),
                  )
                ],
                toolbarHeight: MediaQuery.of(context).size.height * 0.08,
                // elevation: 0,
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
                              color: FakeData().color_mess[_messController
                                  .message['colorOfchat']]['color'],
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
                                  color: FakeData().color_mess[_messController
                                      .message['colorOfchat']]['color'],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectedImage();
                                },
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color: FakeData().color_mess[_messController
                                      .message['colorOfchat']]['color'],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: 9,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 2,
                                            childAspectRatio: 2,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return IconButton(
                                              onPressed: () {
                                                sendEmoji(
                                                    context,
                                                    FakeData().emoji[index]
                                                        ['path']);
                                              },
                                              icon: Image(
                                                image: NetworkImage(
                                                  FakeData().emoji[index]
                                                      ['path'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: FakeData().color_mess[_messController
                                      .message['colorOfchat']]['color'],
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
                          color: FakeData().color_mess[
                              _messController.message['colorOfchat']]['color'],
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
                    const SizedBox(height: 20),
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
                              color: FakeData().color_mess[_messController
                                  .message['colorOfchat']]['color'],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: _messController.listMessItem.map(
                          (e) {
                            if (e.uid == authMethods.user.uid) {
                              return SendCard(data: e);
                            }
                            return RecCard(
                              data: e,
                              color: FakeData().color_mess[_messController
                                  .message['colorOfchat']]['color'],
                            );
                          },
                        ).toList(),
                      ),
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
