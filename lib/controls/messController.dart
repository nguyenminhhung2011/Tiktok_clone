import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/models/messItem.dart';

import '../models/message.dart';
import '../models/user.dart';

class MessController extends GetxController {
  final Rx<List<MessItem>> _listMessItem = Rx<List<MessItem>>([]);
  final Rx<Map<String, dynamic>> _opUser = Rx<Map<String, dynamic>>({});
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  List<MessItem> get listMessItem => _listMessItem.value;
  Map<String, dynamic> get opUser => _opUser.value;
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;
  updateMessWithPerson(String id, String opId) {
    _uid.value = id;
    getDataMessWithPerson(opId);
  }

  getDataMessWithPerson(String opId) async {
    var allMess = await firestore.collection('messages').get();
    String messId = "";
    for (var item in allMess.docs) {
      Message data = Message.fromSnap(item);
      messId =
          (data.listUid.contains(_uid.value) && data.listUid.contains(opId))
              ? data.id
              : messId;
    }
    _listMessItem.bindStream(
      firestore
          .collection('messages')
          .doc(messId)
          .collection('messItems')
          .snapshots()
          .map(
        (event) {
          List<MessItem> result = [];
          for (var item in event.docs) {
            result.add(MessItem.fromSnap(item));
          }
          return result;
        },
      ),
    );
  }

  Future<void> sendMessage(String tittle, int typeMess, String opId) async {
    try {
      if (tittle != "") {
        var allMess = await firestore.collection('messages').get();
        String messId = "";
        for (var item in allMess.docs) {
          Message data = Message.fromSnap(item);
          messId =
              (data.listUid.contains(_uid.value) && data.listUid.contains(opId))
                  ? data.id
                  : messId;
        }
        var allMessItem = await firestore
            .collection('messages')
            .doc(messId)
            .collection('messItems')
            .get();
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(_uid.value).get();
        String itemID = "messItem ${(allMessItem.docs.length).toString()}";

        int border1 = 0;
        int border2 = 25;

        String mess_nearest = "";
        String userSend = "";
        int index = 0;
        for (var item in allMessItem.docs) {
          if (index == allMessItem.docs.length - 1) {
            mess_nearest = (item.data() as Map<String, dynamic>)["itemId"];
            userSend = (item.data() as Map<String, dynamic>)['username'];
          }
          index++;
        }

        border1 =
            ((userDoc.data() as Map<String, dynamic>)['username'] == userSend)
                ? 5
                : 25;
        if (userSend == (userDoc.data() as Map<String, dynamic>)['username']) {
          await firestore
              .collection('messages')
              .doc(messId)
              .collection('messItems')
              .doc(mess_nearest)
              .update(
            {
              'border2': 5,
              'checkEnd': 0,
            },
          );
        }

        MessItem messItem = MessItem(
          messid: messId,
          itemId: itemID,
          typeOfMessage: typeMess,
          tittle: tittle,
          datePublished: DateTime.now(),
          userPic: (userDoc.data() as Map<String, dynamic>)['photoUrl'],
          username: (userDoc.data() as Map<String, dynamic>)['username'],
          uid: (userDoc.data() as Map<String, dynamic>)['uid'],
          border1: border1,
          border2: border2,
          checkEnd: 1,
        );
        await firestore
            .collection('messages')
            .doc(messId)
            .collection('messItems')
            .doc(itemID)
            .set(
              messItem.toJson(),
            );
      }
    } catch (err) {
      print(err.toString());
    }
  }

  updateUserAndOpUser(String id, String opId) {
    _uid.value = id;
    getDataUserOpUser(opId);
  }

  getDataUserOpUser(String opId) async {
    _opUser.value = await getDataUser(opId);
    _user.value = await getDataUser(_uid.value);
    update();
  }

  Future<Map<String, dynamic>> getDataUser(String id) async {
    var userDoc = await firestore.collection('users').doc(id).get();
    Map<String, dynamic> result = (userDoc.data() as Map<String, dynamic>);
    return result;
  }
}
