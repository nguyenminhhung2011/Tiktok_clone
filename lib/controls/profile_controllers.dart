import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/video.dart';

class ProfileControls extends GetxController {
  final Rx<List<Video>> _videoFav = Rx<List<Video>>([]);
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  List<Video> get videoFav => _videoFav.value;
  Rx<String> _uid = "".obs;
  upDateUser(String id) {
    _uid.value = id;
    getUser();
    // print(_user.value);
  }

  getUser() async {
    String username = "";
    String email = "";
    String profilePic = "";
    List<Map<String, dynamic>> allPosts = [];
    List<String> followers = [];
    List<String> following = [];
    String uid = "";
    uid = _uid.value;
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    Map<String, dynamic> data_user = userDoc.data() as Map<String, dynamic>;
    username = data_user['username'];
    profilePic = data_user['photoUrl'];
    email = (userDoc.data() as Map<String, dynamic>)['email'];
    var allVids =
        await firestore.collection('videos').where('uid', isEqualTo: uid).get();
    for (var item in allVids.docs) {
      Map<String, dynamic> i = {
        "id": item.data()['id'],
        "thumbNails": item.data()['thumbNailsPath'],
        "caption": item.data()['caption'],
      };
      allPosts.add(i);
    }
    for (var item in data_user['followers']) {
      followers.add(item);
    }
    for (var item in data_user['following']) {
      following.add(item);
    }
    _user.value = {
      "uid": uid,
      "username": username,
      "email": email,
      "profilePic": profilePic,
      "allPosts": allPosts,
      "followers": followers,
      "following": following,
    };
    //  print(_user.value);
    update();
  }

  updatVideoFav(String id) {
    _uid.value = id;
    getDataVidFav();
  }

  getDataVidFav() async {
    var allVideo = await firestore.collection('videos').get();
    List<Video> result = [];
    for (var item in allVideo.docs) {
      if ((item.data() as Map<String, dynamic>)['likes'].contains(_uid.value)) {
        result.add(Video.fromSnap(item));
      }
    }
    _videoFav.value = result;
    update();
  }
}
