import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:video_compress/video_compress.dart';

import '../models/video.dart';

class upLoadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }

  _getThumbNail(String videoPaht) async {
    var thumbNails = await VideoCompress.getFileThumbnail(videoPaht);
    return thumbNails;
  }

  Future<String> _uploadVideotoStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask upLoadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await upLoadTask;
    String dowLoadUrl = await snap.ref.getDownloadURL();
    return dowLoadUrl;
  }

  Future<String> upLoadImagetoStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbNails').child(id);
    UploadTask upLoadTask = ref.putData(await _getThumbNail(videoPath));
    TaskSnapshot snap = await upLoadTask;
    String dowLoadUrl = await snap.ref.getDownloadURL();
    return dowLoadUrl;
  }

  upLoadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDoc = await firestore.collection('videos').get();
      print(allDoc.docs.length);
      String videoUrl =
          await _uploadVideotoStorage("video ${allDoc.docs.length}", videoPath);
      print(videoUrl);
      String thumbNailsUrl =
          await upLoadImagetoStorage("video ${allDoc.docs.length}", videoPath);
      print(thumbNailsUrl);
      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        id: "video ${allDoc.docs.length}",
        uid: uid,
        proFilePic: (userDoc.data()! as Map<String, dynamic>)['photoUrl'],
        caption: caption,
        songName: songName,
        videoPath: videoPath,
        thumbNailsPath: thumbNailsUrl,
        likes: [],
        commentCount: 0,
        shareCount: 0,
        date: DateTime.now(),
      );
      await firestore
          .collection('videos')
          .doc("video ${allDoc.docs.length}")
          .set(
            video.toJson(),
          );
      Get.snackbar(
        'UpLoad video',
        "Success",
        backgroundColor: Color.fromARGB(255, 136, 199, 250),
      );
    } catch (err) {
      Get.snackbar(
        'Error Upload Video',
        err.toString(),
        backgroundColor: Color.fromARGB(255, 136, 199, 250),
      );
    }
  }
}
