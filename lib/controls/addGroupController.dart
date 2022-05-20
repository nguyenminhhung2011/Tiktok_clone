import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constains.dart';
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

  Future<void> addGroup(String uid, List<User> all_user, String photoPath,
      String nameOfGroup) async {
    try {
      if (nameOfGroup == "") {
        Get.snackbar('Create Group', 'Name of group is null');
        return;
      }
      if (photoPath == "") {
        Get.snackbar('Create Group', 'Please Pick Image of Group');
        return;
      }
      var allMessages = await firestore.collection('messages').get();
      String grID = "message ${allMessages.docs.length}";
    } catch (err) {
      print(err.toString());
    }
  }
}
