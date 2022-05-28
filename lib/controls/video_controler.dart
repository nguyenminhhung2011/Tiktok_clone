import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _listVideo = Rx<List<Video>>([]);
  List<Video> get listVIdeo => _listVideo.value;
  @override
  void onInit() {
    super.onInit();
    _listVideo.bindStream(
      firestore.collection('videos').snapshots().map(
        (event) {
          List<Video> result = [];
          for (var item in event.docs) {
            result.add(Video.fromSnap(item));
          }
          return result;
        },
      ),
    );
  }

  Future<void> likeVideo(String uidUser, List userLike, String idVid) async {
    try {
      var uid = authMethods.user.uid;
      if (userLike.contains(uidUser)) {
        await firestore.collection('videos').doc(idVid).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await firestore.collection('videos').doc(idVid).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      Get.snackbar('Error when like video', err.toString(),
          backgroundColor: Colors.blue);
    }
  }

  Future<void> updateCmtCount(String postId) async {
    try {
      DocumentSnapshot df =
          await firestore.collection('videos').doc(postId).get();
      await firestore.collection('videos').doc(postId).update(
        {
          'commentCount': (df.data() as Map<String, dynamic>)['commentCount']++,
        },
      );
      print('pluss');
    } catch (err) {
      print(err.toString());
    }
  }
}
