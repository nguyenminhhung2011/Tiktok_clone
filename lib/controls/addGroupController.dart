import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/storage_methods.dart';

import '../constains.dart';
import '../models/message.dart';
import '../models/user.dart';

class AddGroupController extends GetxController {
  final Rx<List<User>> _allUser = Rx<List<User>>([]);

  List<User> get allUser => _allUser.value;

  getAllUser() async {
    _allUser.bindStream(
      firestore.collection('users').snapshots().map(
        (event) {
          List<User> result = [];
          for (var item in event.docs) {
            result.add(User.fromSnap(item));
          }
          return result;
        },
      ),
    );
  }

  removeUserController(String uid) async {
    _allUser.value.removeWhere((element) => element.uid == uid);
    update();
  }

  addUserController(User user) async {
    _allUser.value.add(user);
    update();
  }

  Future<void> addGroup(
      List<User> allUser, Uint8List file, String nameOfGroup) async {
    try {
      if (nameOfGroup == "") {
        Get.snackbar(
          'Create Group',
          'Name of group is null',
          backgroundColor: const Color.fromARGB(255, 32, 211, 231),
        );
        return;
      }
      if (file == Null) {
        Get.snackbar(
          'Create Group',
          'Please Pick Image of Group',
          backgroundColor: const Color.fromARGB(255, 32, 211, 231),
        );
        return;
      }
      var allMessages = await firestore.collection('messages').get();
      String grID = "message ${allMessages.docs.length}";
      String photoPath =
          await StorageMethods().UpLoadImageGroupToStorage(grID, file);
      List<String> lUid = [];
      List<String> lUsername = [];
      List<String> lPhoto = [];
      for (var item in allUser) {
        lUid.add(item.uid);
        lUsername.add(item.username);
        lPhoto.add(item.photoUrl);
      }
      Message mess = Message(
        id: grID,
        messNearest: "Don't have mess Nearest",
        groupOrWithPerson: 1,
        photoGroup_member: photoPath,
        listUid: lUid,
        username: lUsername,
        photoUrl: lPhoto,
        colorOfchat: 8,
        nameOfGroup: nameOfGroup,
      );
      await firestore.collection('messages').doc(grID).set(mess.toJson());
    } catch (err) {
      print(err.toString());
    }
  }
}
