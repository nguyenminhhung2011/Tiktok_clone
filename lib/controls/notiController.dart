import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/message.dart';
import '../models/user.dart';

class NotiController extends GetxController {
  // Message _controller
  final Rx<List<Message>> _listMessage = Rx<List<Message>>([]);
  final Rx<List<User>> _listUser = Rx<List<User>>([]);

  List<Message> get listMessage => _listMessage.value;
  List<User> get listUser => _listUser.value;

  Rx<String> _uid = "".obs;

  updateMessage(String id) {
    _uid.value = id;
    getDataMessage();
  }

  getDataMessage() async {
    _listMessage.bindStream(
      firestore.collection('messages').snapshots().map(
        (event) {
          List<Message> result = [];
          for (var item in event.docs) {
            Message data = Message.fromSnap(item);
            if (data.listMem.contains(_uid.value)) {
              result.add(data);
            }
          }
          return result;
        },
      ),
    );
  }

  searchWithType(String type) async {
    _listUser.bindStream(
      firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: type)
          .snapshots()
          .map(
        (event) {
          List<User> result = [];
          for (var item in event.docs) {
            if ((item.data() as Map<String, dynamic>)['uid'] != _uid.value) {
              result.add(User.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
  }

  createMessPerson(String id) {
    creatMessageWithPerson(id);
  }

  creatMessageWithPerson(String id) async {
    try {
      String uid = authMethods.user.uid;
      var allMessage = await firestore.collection('messages').get();
      int check = 0;
      for (var item in allMessage.docs) {
        Message data = Message.fromSnap(item);
        check = (data.groupOrWithPerson == 0 &&
                data.listMem.contains(uid) &&
                data.listMem.contains(id))
            ? 1
            : check;
      }
      if (check == 0) {
        List listMem = [uid, id];
        Message mess = Message(
          id: "message ${allMessage.docs.length}",
          messNearest: "",
          groupOrWithPerson: 0,
          photoGroup_member: "",
          listMem: listMem,
        );
        await firestore
            .collection('messages')
            .doc("message ${allMessage.docs.length}")
            .set(mess.toJson());
      } else {
        return;
      }
    } catch (err) {
      print(err.toString());
    }
  }
}

class MessItem {}
