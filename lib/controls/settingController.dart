import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constains.dart';
import '../models/message.dart';

class SettingControllers extends GetxController {
  updateColorOfChat(String opId, int colorChoose) {
    updateData(opId, colorChoose);
  }

  updateData(String opId, int colorChoose) async {
    String messID = "";
    var allMessage = await firestore.collection('messages').get();
    for (var item in allMessage.docs) {
      Message data = Message.fromSnap(item);
      if (data.listUid.contains(authMethods.user.uid) &&
          data.listUid.contains(opId)) {
        messID = data.id;
        break;
      }
    }
    await firestore
        .collection('messages')
        .doc(messID)
        .update({'colorOfchat': colorChoose});
  }
}
