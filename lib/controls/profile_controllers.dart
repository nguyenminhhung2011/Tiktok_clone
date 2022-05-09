import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

class ProfileControls extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;
  getID(String id) {
    _uid.value = id;
    print(1);
    getUser();
  }

  getUser() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    _user.value = userDoc.data() as Map<String, dynamic>;
    print(_user.value);
    update();
  }
}
