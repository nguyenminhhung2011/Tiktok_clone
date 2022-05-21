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
      List<User> all_user, Uint8List file, String nameOfGroup) async {
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
      List<String> l_uid = [];
      List<String> l_username = [];
      List<String> l_photo = [];
      for (var item in all_user) {
        l_uid.add(item.uid);
        l_username.add(item.username);
        l_photo.add(item.photoUrl);
      }
      Message mess = Message(
        id: grID,
        messNearest: "Don\'t have mess Nearest",
        groupOrWithPerson: 1,
        photoGroup_member: photoPath,
        listUid: l_uid,
        username: l_username,
        photoUrl: l_photo,
        colorOfchat: 8,
        nameOfGroup: nameOfGroup,
      );
      await firestore.collection('messages').doc(grID).set(mess.toJson());
    } catch (err) {
      print(err.toString());
    }
  }
}
