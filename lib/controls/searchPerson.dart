import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/models/video.dart';

import '../models/user.dart';

class SearchController extends GetxController {
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

  final Rx<List<Video>> _searchVideo = Rx<List<Video>>([]);
  List<Video> get searchVideo => _searchVideo.value;
  searchVideoWithType(String typeVideo) async {
    _searchVideo.bindStream(firestore
        .collection('videos')
        .where('username', isGreaterThanOrEqualTo: typeVideo)
        .snapshots()
        .map((event) {
      List<Video> result = [];
      for (var item in event.docs) {
        result.add(Video.fromSnap(item));
      }
      return result;
    }));
  }
}
