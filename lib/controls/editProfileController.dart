import 'package:get/get.dart';

import '../constains.dart';

class EditProfileController extends GetxController {
  editProFile(String uid, String username, String bio, String photoUrl) async {
    await firestore.collection('users').doc(uid).update({
      'username': username,
      'bio': bio,
      //'photoUrl': photoUrl,
    });
  }
}
