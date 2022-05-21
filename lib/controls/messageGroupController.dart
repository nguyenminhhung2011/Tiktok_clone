import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constains.dart';
import '../models/messItem.dart';
import '../models/message.dart';

class MessageGroupController extends GetxController {
  final Rx<List<MessItem>> _listMessages = Rx<List<MessItem>>([]);
  final Rx<List<String>> _allImagesInMess = Rx<List<String>>([]);

  List<MessItem> get listMessages => _listMessages.value;
  List<String> get allImagesInMess => _allImagesInMess.value;
  Rx<String> _uid = "".obs;
  upDateMessages(String id, String messId) {
    _uid.value = id;
    getDataMessages(messId);
  }

  getDataMessages(String messID) async {
    _listMessages.bindStream(
      firestore
          .collection('messages')
          .doc(messID)
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

  getAllImagesInMess(String messId) async {
    _allImagesInMess.bindStream(firestore
        .collection('messages')
        .doc(messId)
        .collection('messItems')
        .snapshots()
        .map((event) {
      List<String> result = [];
      for (var item in event.docs) {
        MessItem data = MessItem.fromSnap(item);
        if (data.typeOfMessage == 1) {
          result.add(data.tittle);
        }
      }
      return result;
    }));
  }

  Future<void> sendMessage(String tittle, int typeMess, String messId) async {
    try {
      if (tittle != "") {
        var allMessagesItem = await firestore
            .collection('messages')
            .doc(messId)
            .collection('messItems')
            .get();
        String itemID = "messItem ${allMessagesItem.docs.length}";
        String uid = authMethods.user.uid;
        var userDoc = await firestore.collection('users').doc(uid).get();
        int border1 = 0;
        int border2 = 30;
        String mess_nearest = "";
        String userSend = "";
        for (var item in allMessagesItem.docs) {
          if ("messItem ${(allMessagesItem.docs.length - 1).toString()}" ==
              (item.data() as Map<String, dynamic>)['itemId']) {
            mess_nearest = (item.data() as Map<String, dynamic>)["itemId"];
            userSend = (item.data() as Map<String, dynamic>)['username'];
            break;
          }
        }
        border1 =
            ((userDoc.data() as Map<String, dynamic>)['username'] == userSend)
                ? 5
                : 30;
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
          index: allMessagesItem.docs.length,
        );
        await firestore.collection('messages').doc(messId).update({
          'messNearest': (typeMess == 0) ? tittle : "Receive Picture",
        });

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
}
