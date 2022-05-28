import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/models/messItem.dart';

import '../models/message.dart';

class MessController extends GetxController {
  final Rx<List<MessItem>> _listMessItem = Rx<List<MessItem>>([]);
  final Rx<Map<String, dynamic>> _opUser = Rx<Map<String, dynamic>>({});
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  final Rx<Map<String, dynamic>> _message = Rx<Map<String, dynamic>>({});
  final Rx<List<String>> _allImageInMess = Rx<List<String>>([]);

  Map<String, dynamic> get message => _message.value;
  List<String> get allImageInMess => _allImageInMess.value;
  List<MessItem> get listMessItem => _listMessItem.value;
  Map<String, dynamic> get opUser => _opUser.value;
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  updateMessWithPerson(String id, String opId) {
    _uid.value = id;
    getDataMessWithPerson(opId);
  }

  int mySortComparison(MessItem a, MessItem b) {
    if (a.index < b.index) {
      return -1;
    } else if (a.index > b.index) {
      return 1;
    }
    return 0;
  }

  getDataMessWithPerson(String opId) async {
    var allMess = await firestore.collection('messages').get();
    String messId = "";
    for (var item in allMess.docs) {
      Message data = Message.fromSnap(item);
      messId =
          (data.listUid.contains(_uid.value) && data.listUid.contains(opId))
              ? data.id
              : messId;
      if ((data.listUid.contains(_uid.value) && data.listUid.contains(opId))) {
        _message.value = data.toJson();
        break;
      }
    }
    _allImageInMess.value.clear();
    _listMessItem.bindStream(
      firestore
          .collection('messages')
          .doc(messId)
          .collection('messItems')
          .snapshots()
          .map(
        (event) {
          List<MessItem> result = [];
          for (var item in event.docs) {
            result.add(MessItem.fromSnap(item));
            if ((item.data())['typeOfMessage'] == 1) {
              _allImageInMess.value
                  .add((item.data())['tittle']);
            }
          }
          result.sort(mySortComparison);
          return result;
        },
      ),
    );
    update();
  }

  Future<void> sendMessage(String tittle, int typeMess, String opId) async {
    try {
      if (tittle != "") {
        var allMess = await firestore.collection('messages').get();
        String messId = "";
        for (var item in allMess.docs) {
          Message data = Message.fromSnap(item);
          messId = (data.listUid.contains(_uid.value) &&
                  data.listUid.contains(opId) &&
                  data.groupOrWithPerson == 0)
              ? data.id
              : messId;
        }
        var allMessItem = await firestore
            .collection('messages')
            .doc(messId)
            .collection('messItems')
            .get();
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(_uid.value).get();
        String itemID = "messItem ${(allMessItem.docs.length).toString()}";

        int border1 = 0;
        int border2 = 30;

        String messNearest = "";
        String userSend = "";
        for (var item in allMessItem.docs) {
          if ("messItem ${(allMessItem.docs.length - 1).toString()}" ==
              (item.data())['itemId']) {
            messNearest = (item.data())["itemId"];
            userSend = (item.data())['username'];
            break;
          }
        }

        await firestore.collection('messages').doc(messId).update({
          'messNearest': (typeMess == 0)
              ? tittle
              : (typeMess == 1)
                  ? "Receive Picture"
                  : "Receive Emoju",
        });

        border1 =
            ((userDoc.data() as Map<String, dynamic>)['username'] == userSend)
                ? 5
                : 30;
        if (userSend == (userDoc.data() as Map<String, dynamic>)['username']) {
          await firestore
              .collection('messages')
              .doc(messId)
              .collection('messItems')
              .doc(messNearest)
              .update(
            {
              'border2': 5,
              'checkEnd': 0,
            },
          );
        }

        MessItem messItem = MessItem(
          messid: messId,
          itemId: itemID,
          typeOfMessage: typeMess,
          tittle: tittle,
          datePublished: DateTime.now(),
          userPic: (userDoc.data() as Map<String, dynamic>)['photoUrl'],
          username: (userDoc.data() as Map<String, dynamic>)['username'],
          uid: (userDoc.data() as Map<String, dynamic>)['uid'],
          border1: border1,
          border2: border2,
          checkEnd: 1,
          index: allMessItem.docs.length,
        );
        await firestore
            .collection('messages')
            .doc(messId)
            .collection('messItems')
            .doc(itemID)
            .set(
              messItem.toJson(),
            );
      }
    } catch (err) {
      print(err.toString());
    }
  }

  updateUserAndOpUser(String id, String opId) {
    _uid.value = id;
    getDataUserOpUser(opId);
  }

  getDataUserOpUser(String opId) async {
    _opUser.value = await getDataUser(opId);
    _user.value = await getDataUser(_uid.value);
    update();
  }

  Future<Map<String, dynamic>> getDataUser(String id) async {
    var userDoc = await firestore.collection('users').doc(id).get();
    Map<String, dynamic> result = (userDoc.data() as Map<String, dynamic>);
    return result;
  }

  upDateAllImageInMess(String idOp, String uid) {
    _uid.value = uid;
    getAllImageInMess(idOp);
  }

  getAllImageInMess(String opId) async {
    var allMess = await firestore.collection('messages').get();
    String messId = "";
    for (var item in allMess.docs) {
      Message data = Message.fromSnap(item);
      messId =
          (data.listUid.contains(_uid.value) && data.listUid.contains(opId))
              ? data.id
              : messId;
    }
    _allImageInMess.bindStream(
      firestore
          .collection('messages')
          .doc(messId)
          .collection('messItems')
          .snapshots()
          .map(
        (event) {
          List<String> result = [];
          for (var item in event.docs) {
            MessItem data = MessItem.fromSnap(item);
            if (data.typeOfMessage == 1) result.add(data.tittle);
          }
          return result;
        },
      ),
    );
  }
}
