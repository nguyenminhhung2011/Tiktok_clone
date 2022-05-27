import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/controls/storage_methods.dart';
import 'package:tiktok_clone/models/user.dart' as models;

import '../screens/Home_screen/Home_screen.dart';
import '../screens/login_screen.dart';

class AuthControls extends GetxController {
  static AuthControls instance = Get.find();
  var _firStore = FirebaseFirestore.instance;
  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setIntialScreen); // ghe moi khi co su thay doi
  }

  _setIntialScreen(User? user) {
    //if user == null screen will go to Login screen else go to home screen
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<String> SignUp({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List image,
  }) async {
    String res = "Some error";
    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password); // get uid of user
        String photouUrl = await StorageMethods()
            .UploadImageStorage('ProfilePic', image, false);
        models.User user = models.User(
          username: username,
          password: password,
          email: email,
          photoUrl: photouUrl,
          followers: [],
          following: [],
          uid: cred.user!.uid,
          bio: bio,
        );
        await _firStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "Success";
      } else {
        res = "Input is not null";
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
      if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      } else if (err.code == 'invalid-email') {
        res = 'The Email address is badly formatted';
      } else if (err.code == 'email-already-in-use') {
        res = 'The Email address is already in use by another account';
      }
    }
    return res;
  }

  Future<String> LoginUser(String email, String password) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please all the feilds';
      }
      print(res);
    } on FirebaseAuthException catch (err) {
      print(err.code);
      res = err.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> getUser() async {
    Map<String, dynamic> user = {};
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(authMethods.user.uid).get();
    user = userDoc.data()! as Map<String, dynamic>;
    return user;
  }

  getget() {}
}
