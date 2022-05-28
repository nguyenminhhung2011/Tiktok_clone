import 'package:get/get.dart';

import '../constains.dart';
import '../models/message.dart';

class SettingControllers extends GetxController {
  final Rx<List<Map<String, dynamic>>> _listMemberInGroup =
      Rx<List<Map<String, dynamic>>>([]);

  List<Map<String, dynamic>> get listMemberInGroup => _listMemberInGroup.value;

  getAllMemberInGroup(String messId) async {
    _listMemberInGroup.bindStream(
      firestore.collection('messages').doc(messId).snapshots().map(
        (event) {
          List<Map<String, dynamic>> result = [];
          Message data = Message.fromSnap(event);
          for (int i = 0; i < data.listUid.length; i++) {
            result.add(
              {
                'photoPath': data.photoUrl[i],
                'username': data.username[i],
                'bio': "In Group"
              },
            );
          }
          return result;
        },
      ),
    );
  }

  updateColorOfChat(String opId, int colorChoose, int typeOfMess) {
    updateData(opId, colorChoose, typeOfMess);
  }

  updateData(String opId, int colorChoose, int typeOfMess) async {
    String messID = "";
    if (typeOfMess == 0) {
      var allMessage = await firestore.collection('messages').get();
      for (var item in allMessage.docs) {
        Message data = Message.fromSnap(item);
        if (data.listUid.contains(authMethods.user.uid) &&
            data.listUid.contains(opId) &&
            data.groupOrWithPerson == 0) {
          messID = data.id;
          break;
        }
      }
    } else {
      messID = opId;
    }
    await firestore
        .collection('messages')
        .doc(messID)
        .update({'colorOfchat': colorChoose});
  }
}
