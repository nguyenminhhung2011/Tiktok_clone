import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comments {
  String commentId;
  String postId;
  String uid;
  final datePublished;
  List likes;
  String title;
  Comments({
    required this.commentId,
    required this.postId,
    required this.uid,
    required this.datePublished,
    required this.likes,
    required this.title,
  });
  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'postId': postId,
        'uid': uid,
        'datePublished': datePublished,
        'likes': likes,
        'title': title,
      };

  static Comments fromSnap(DocumentSnapshot snap) {
    return Comments(
      commentId: snap['commentId'],
      postId: snap['postId'],
      uid: snap['uid'],
      datePublished: snap['datePublished'],
      likes: snap['likes'],
      title: snap['title'],
    );
  }
}
