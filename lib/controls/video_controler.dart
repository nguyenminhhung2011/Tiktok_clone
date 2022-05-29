import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/notification.dart';
import '../models/user.dart';
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

  Future<void> likeVideo(
      String uidUser, List userLike, String idVid, String uidOp) async {
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
        addDataNotiFi(uidOp, idVid);
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

  addDataNotiFi(String uidOp, String idVid) async {
    var userDoc =
        await firestore.collection('users').doc(authMethods.user.uid).get();

    var vidDoc = await firestore.collection('videos').doc(idVid).get();
    Video vid = Video.fromSnap(vidDoc);
    User user = User.fromSnap(userDoc);
    if (uidOp != user.uid) {
      var allNoti = await firestore.collection('noti').get();
      String notiId = 'noti ${allNoti.docs.length}';

      Noti data = Noti(
        notiId: notiId,
        typeNoti: 1,
        username: user.username,
        profilePic: user.photoUrl,
        uid: user.uid,
        uidRec: uidOp,
        postUid: vid.id,
        postPath: vid.thumbNailsPath,
        commentUid: "",
      );

      try {
        await firestore.collection('noti').doc(notiId).set(data.toJson());
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
