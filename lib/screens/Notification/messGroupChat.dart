import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/screens/Notification/settingScreen.dart';
import 'package:tiktok_clone/screens/Notification/widget/recCard.dart';
import 'package:tiktok_clone/screens/Notification/widget/sendCard.dart';

import '../../controls/fake_data.dart';
import '../../controls/messageGroupController.dart';
import '../../controls/storage_methods.dart';
import '../../models/message.dart';
import '../../utils/untils.dart';
import '../../widgets/Avtar_circle.dart';

class MessGroupScreen extends StatefulWidget {
  final Message data;
  const MessGroupScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<MessGroupScreen> createState() => _MessGroupScreenState();
}

class _MessGroupScreenState extends State<MessGroupScreen> {
  final TextEditingController _stringController = TextEditingController();
  final MessageGroupController _messGroupController = MessageGroupController();
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    _messGroupController.upDateMessages(authMethods.user.uid, widget.data.id);
    _messGroupController.getAllImagesInMess(widget.data.id);
  }

  void sendMessages() {
    _messGroupController.sendMessage(_stringController.text, 0, widget.data.id);
    setState(() {
      _stringController.clear();
    });
  }

  void sendImage(BuildContext context) async {
    String photoUrl =
        await StorageMethods().UploadImageStorage('MessagePics', _image!, true);
    await _messGroupController.sendMessage(photoUrl, 1, widget.data.id);
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
                          color: FakeData().color_mess[widget.data.colorOfchat]
                              ['color'],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: FakeData().color_mess[widget.data.colorOfchat]['color'],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(
                      listMess: _messGroupController.allImagesInMess,
                      userOP: widget.data.toJson(),
                      typeOfMess: 1,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: FakeData().color_mess[widget.data.colorOfchat]['color'],
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
                avtPath: widget.data.photoGroup_member,
                sizeAvt: 60,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.nameOfGroup,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${widget.data.listUid.length} members in group chat',
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
                        color: FakeData().color_mess[widget.data.colorOfchat]
                            ['color'],
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
                            color: FakeData()
                                .color_mess[widget.data.colorOfchat]['color'],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            selectedImage();
                          },
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: FakeData()
                                .color_mess[widget.data.colorOfchat]['color'],
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.gif_box_outlined,
                            color: FakeData()
                                .color_mess[widget.data.colorOfchat]['color'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessages();
                  },
                  icon: Icon(
                    Icons.send,
                    color: FakeData().color_mess[widget.data.colorOfchat]
                        ['color'],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarCircle(
                      avtPath: widget.data.photoGroup_member,
                      sizeAvt: 90,
                    ),
                    Text(
                      widget.data.nameOfGroup,
                      style: TextStyle(
                        color: FakeData().color_mess[widget.data.colorOfchat]
                            ['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${widget.data.listUid.length} members in group chat',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: _messGroupController.listMessages.map(
                        (e) {
                          if (e.uid == authMethods.user.uid) {
                            return SendCard(data: e);
                          }
                          return RecCard(
                            data: e,
                            color: FakeData()
                                .color_mess[widget.data.colorOfchat]['color'],
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
