import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<List> getListUserWithUid(String email) async {
    QuerySnapshot snap = await _fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    List users = snap.docs.map((e) => e.data()).toList();
    return users;
  }

  Future<List> getAlluser() async {
    QuerySnapshot snap = await _fireStore.collection('users').get();
    List users = snap.docs.map((e) => e.data()).toList();
    return users;
  }
}
