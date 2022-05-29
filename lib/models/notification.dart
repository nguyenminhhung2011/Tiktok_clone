import 'package:cloud_firestore/cloud_firestore.dart';

class Noti {
  String notiId;
  int typeNoti; //0: follow, 1: like Post 2: like Comments
  String username;
  String profilePic;
  String uid;
  String uidRec;
  String postUid;
  String postPath;
  String commentUid;
  Noti({
    required this.notiId,
    required this.typeNoti,
    required this.username,
    required this.profilePic,
    required this.uid,
    required this.uidRec,
    required this.postUid,
    required this.postPath,
    required this.commentUid,
  });

  Map<String, dynamic> toJson() => {
        'notiId': notiId,
        'typeNoti': typeNoti,
        'username': username,
        'profilePic': profilePic,
        'uid': uid,
        'uidRec': uidRec,
        'postUid': postUid,
        'postPath': postPath,
        'commentUid': commentUid,
      };

  static Noti fromSnap(DocumentSnapshot snap) {
    return Noti(
      notiId: snap['notiId'],
      typeNoti: snap['typeNoti'],
      username: snap['username'],
      profilePic: snap['profilePic'],
      uid: snap['uid'],
      uidRec: snap['uidRec'],
      postUid: snap['postUid'],
      postPath: snap['postPath'],
      commentUid: snap['commentUid'],
    );
  }
}
