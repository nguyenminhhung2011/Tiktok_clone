import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/user.dart';
import '../models/video.dart';

class ProDiffControl extends GetxController {
  final Rx<List<Video>> _listVideo = Rx<List<Video>>([]);
  final Rx<List<Video>> _listFavVideo = Rx<List<Video>>([]);
  final Rx<List<User>> _listFollowing = Rx<List<User>>([]);
  final Rx<List<User>> _listFollowers = Rx<List<User>>([]);

  List<Video> get listVideo => _listVideo.value;
  List<Video> get ListFavVideo => _listFavVideo.value;
  List<User> get ListFollowing => _listFollowing.value;
  List<User> get ListFollowers => _listFollowers.value;

  getAllVideo(String uid) async {
    _listVideo.bindStream(
      firestore.collection('videos').snapshots().map(
        (event) {
          List<Video> result = [];
          for (var item in event.docs) {
            Video data = Video.fromSnap(item);
            if (data.uid == uid) {
              result.add(data);
            }
          }
          return result;
        },
      ),
    );
  }

  getAllFavVideo(String uid) async {
    _listFavVideo.bindStream(
      firestore.collection('videos').snapshots().map(
        (event) {
          List<Video> result = [];
          for (var item in event.docs) {
            Video data = Video.fromSnap(item);
            if (data.likes.contains(uid)) {
              result.add(data);
            }
          }
          return result;
        },
      ),
    );
  }

  getAllFollowing(String uid) async {
    _listFollowing
        .bindStream(firestore.collection('users').snapshots().map((e) {
      List<User> result = [];
      for (var item in e.docs) {
        User data = User.fromSnap(item);
        if (data.followers.contains(uid)) {
          result.add(data);
        }
      }
      return result;
    }));
  }

  getAllFollowers(String uid) async {
    _listFollowers
        .bindStream(firestore.collection('users').snapshots().map((e) {
      List<User> result = [];
      for (var item in e.docs) {
        User data = User.fromSnap(item);
        if (data.following.contains(uid)) {
          result.add(data);
        }
      }
      return result;
    }));
  }

  Future<void> followingUser(String uidUser) async {
    try {
      var userDoc =
          await firestore.collection('users').doc(authMethods.user.uid).get();
      User user = User.fromSnap(userDoc);
      String uid = authMethods.user.uid;
      if (user.following.contains(uidUser)) {
        firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([uidUser])
        });
        firestore.collection('users').doc(uidUser).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
      } else {
        firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([uidUser])
        });
        firestore.collection('users').doc(uidUser).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
      }
      update();
    } catch (err) {
      print(err.toString());
    }
  }
}
