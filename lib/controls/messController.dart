import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/messItem.dart';

class MessController extends GetxController {
  final Rx<List<MessItem>> _listMessItem = Rx<List<MessItem>>([]);
  List<MessItem> get listMessItem => _listMessItem.value;
}
