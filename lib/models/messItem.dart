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
  MessItem({
    required this.messid,
    required this.itemId,
    required this.typeOfMessage,
    required this.tittle,
    required this.datePublished,
    required this.userPic,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'messid': messid,
        'itemId': itemId,
        'typeOfMessage': typeOfMessage,
        'tittle': tittle,
        'datePublished': datePublished,
        'userPic': userPic,
        'username': username,
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
    );
  }
}
