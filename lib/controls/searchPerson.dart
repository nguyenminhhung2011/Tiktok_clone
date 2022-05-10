import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/user.dart';

class SearchPersonController extends GetxController {
  final Rx<List<User>> _searchUser = Rx<List<User>>([]);
  List<User> get searchUser => _searchUser.value;
  searchWithType(String typeUser) async {
    _searchUser.bindStream(firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: typeUser)
        .snapshots()
        .map((event) {
      List<User> result = [];
      for (var item in event.docs) {
        result.add(User.fromSnap(item));
      }
      return result;
    }));
  }
}
