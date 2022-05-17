import 'package:cloud_firestore/cloud_firestore.dart';
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
            Message d = Message.fromSnap(item);
            if (d.listUid.contains(_uid.value)) {
              result.add(d);
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
                data.listUid.contains(uid) &&
                data.listUid.contains(id))
            ? 1
            : check;
      }
      if (check == 0) {
        List listUid = [];
        List username = [];
        List photoUrl = [];
        var userDoc = await firestore.collection('users').get();
        for (var item in userDoc.docs) {
          User data = User.fromSnap(item);
          if (data.uid == id || data.uid == uid) {
            listUid.add(data.uid);
            username.add(data.username);
            photoUrl.add(data.photoUrl);
          }
        }
        Message mess = Message(
          id: "message ${allMessage.docs.length}",
          messNearest: "Don\t have mess Nearest",
          groupOrWithPerson: 0,
          photoGroup_member: "",
          listUid: listUid,
          username: username,
          photoUrl: photoUrl,
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

  int getIndexUserInList(String id, List listMem) {
    int index = 0;
    for (var item in listMem) {
      if (item == id) {
        return index;
      }
      index++;
    }
    return index;
  }
}
