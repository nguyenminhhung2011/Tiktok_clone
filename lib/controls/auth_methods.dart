import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/storage_methods.dart';
import 'package:tiktok_clone/models/user.dart' as models;

var _auth = FirebaseAuth.instance;
var _firStore = FirebaseFirestore.instance;

class AuthMethods {
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
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
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
      //print(err.code);
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
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Input is null';
      }
      print(res);
    } on FirebaseAuthException catch (err) {
      print(err.code);
      res = err.code;
    }

    return res;
  }
}
