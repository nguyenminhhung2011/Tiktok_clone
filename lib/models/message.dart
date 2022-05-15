import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  String id;
  // String uidPerson1;
  // String uidPerson2;
  // String profilePic1;
  // String profilePic2;
  // String userName1;
  // String userName2;
  String messNearest;
  int groupOrWithPerson; // 0: group 1: Person
  String photoGroup_member;
  List listMem;
  Message({
    required this.id,
    // required this.uidPerson1,
    // required this.uidPerson2,
    // required this.profilePic1,
    // required this.profilePic2,
    // required this.userName1,
    // required this.userName2,
    required this.messNearest,
    required this.photoGroup_member,
    required this.groupOrWithPerson,
    required this.listMem,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        // 'uidPerson1': uidPerson1,
        // 'uidPerson2': uidPerson2,
        // 'profilePic1': profilePic1,
        // 'profilePic2': profilePic2,
        // 'userName1': userName1,
        // 'userName2': userName2,
        'messNearest': messNearest,
        'groupOrWithPerson': groupOrWithPerson,
        'listMem': listMem,
        'photoGroup_member': photoGroup_member,
      };

  static Message fromSnap(DocumentSnapshot snap) {
    return Message(
      id: snap['id'],
      // uidPerson1: snap['uidPerson1'],
      // uidPerson2: snap['uidPerson2'],
      // profilePic1: snap['profilePic1'],
      // profilePic2: snap['profilePic2'],
      // userName1: snap['userName1'],
      // userName2: snap['userName2'],
      messNearest: snap['messNearest'],
      groupOrWithPerson: snap['groupOrWithPerson'],
      listMem: snap['listMem'],
      photoGroup_member: snap['photoGroup_member'],
    );
  }
}
