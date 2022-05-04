import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Video {
  String username;
  String id;
  String uid;
  String proFilePic;
  String caption;
  String songName;
  String videoPath;
  String thumbNailsPath;
  List likes;
  int commentCount;
  int shareCount;
  Video({
    required this.username,
    required this.id,
    required this.uid,
    required this.proFilePic,
    required this.caption,
    required this.songName,
    required this.videoPath,
    required this.thumbNailsPath,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'uid': uid,
        'proFilePic': proFilePic,
        'caption': caption,
        'songName': songName,
        'videoPath': videoPath,
        'thumbNailsPath': thumbNailsPath,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot['username'],
      id: snapshot['id'],
      uid: snapshot['uid'],
      proFilePic: snapshot['proFilePic'],
      caption: snapshot['caption'],
      songName: snapshot['songName'],
      videoPath: snapshot['videoPath'],
      thumbNailsPath: snapshot['thumbNailsPath'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
    );
  }
}
