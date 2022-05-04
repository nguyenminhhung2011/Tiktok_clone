import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _listVideo = Rx<List<Video>>([]);
  List<Video> get listVIdeo => _listVideo.value;
  void onInit() {
    super.onInit();
    _listVideo.bindStream(
      firestore.collection('videos').snapshots().map(
        (event) {
          List<Video> result = [];
          for (var item in event.docs) {
            result.add(Video.fromSnap(item));
          }
          print(result.length);
          return result;
        },
      ),
    );
  }
}
