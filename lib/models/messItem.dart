import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessItem {
  String messid;
  String itemId;
  int typeOfMessage;
  String tittle;
  final datePublished;
  String userPic;
  String username;
  String uid;
  int border1;
  int border2;
  int checkEnd;
  MessItem({
    required this.messid,
    required this.itemId,
    required this.typeOfMessage,
    required this.tittle,
    required this.datePublished,
    required this.userPic,
    required this.username,
    required this.uid,
    required this.border1,
    required this.border2,
    required this.checkEnd, // 0: don't have icon 1: have icon
  });

  Map<String, dynamic> toJson() => {
        'messid': messid,
        'itemId': itemId,
        'typeOfMessage': typeOfMessage,
        'tittle': tittle,
        'datePublished': datePublished,
        'userPic': userPic,
        'username': username,
        'uid': uid,
        'border1': border1,
        'border2': border2,
        'checkEnd': checkEnd,
      };
  static MessItem fromSnap(DocumentSnapshot snap) {
    return MessItem(
      messid: snap['messid'],
      itemId: snap['itemId'],
      typeOfMessage: snap['typeOfMessage'],
      tittle: snap['tittle'],
      datePublished: snap['datePublished'],
      userPic: snap['userPic'],
      username: snap['username'],
      uid: snap['uid'],
      border1: snap['border1'],
      border2: snap['border2'],
      checkEnd: snap['checkEnd'],
    );
  }
}
