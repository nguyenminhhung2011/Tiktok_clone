import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../models/message.dart';
import '../models/notification.dart';
import '../models/user.dart';

class NotiController extends GetxController {
  // Message _controller
  final Rx<List<Message>> _listMessage = Rx<List<Message>>([]);
  final Rx<List<User>> _listUser = Rx<List<User>>([]);
  final Rx<Map<String, dynamic>> _message = Rx<Map<String, dynamic>>({});
  final Rx<List<Message>> _listGroupMessage = Rx<List<Message>>([]);
  final Rx<List<User>> _allUser = Rx<List<User>>([]);
  final Rx<List<Noti>> _allNoti = Rx<List<Noti>>([]);

  List<Message> get listMessage => _listMessage.value;
  List<User> get listUser => _listUser.value;
  Map<String, dynamic> get message => _message.value;
  List<Message> get listGroupMessage => _listGroupMessage.value;
  List<User> get allUser => _allUser.value;
  List<Noti> get allNoti => _allNoti.value;
  final Rx<String> _uid = "".obs;

  updateGroupMessage(String id) {
    _uid.value = id;
    getDataGroupMessage();
  }

  getDataGroupMessage() async {
    _listGroupMessage.bindStream(
      firestore.collection('messages').snapshots().map(
        (event) {
          List<Message> result = [];
          for (var item in event.docs) {
            Message d = Message.fromSnap(item);
            if (d.listUid.contains(_uid.value) && d.groupOrWithPerson == 1) {
              result.add(d);
            }
          }
          return result;
        },
      ),
    );
  }

  updateMessage(String id) {
    _uid.value = id;
    getDataMessage();
  }

  removeUserInAllUser(String uid) async {
    _allUser.value.removeWhere((element) => element.uid == uid);
    update();
  }

  addUserInAllUser(String uid) async {
    var userDoc = await firestore.collection('users').doc(uid).get();
    _allUser.value.add(User.fromSnap(userDoc));
    update();
  }

  getDataMessage() async {
    _listMessage.bindStream(
      firestore.collection('messages').snapshots().map(
        (event) {
          List<Message> result = [];
          for (var item in event.docs) {
            Message d = Message.fromSnap(item);
            if (d.listUid.contains(_uid.value) && d.groupOrWithPerson == 0) {
              result.add(d);
            }
          }
          return result;
        },
      ),
    );
  }

  getAllUser() async {
    _allUser.bindStream(
      firestore.collection('users').snapshots().map((event) {
        List<User> result = [];
        for (var item in event.docs) {
          result.add(User.fromSnap(item));
        }
        return result;
      }),
    );
  }

  searchWithType(String type) async {
    _listUser.bindStream(
      firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: type)
          .snapshots()
          .map(
        (event) {
          List<User> result = [];
          for (var item in event.docs) {
            if ((item.data())['uid'] != _uid.value) {
              result.add(User.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
  }

  createMessPerson(String id) {
    creatMessageWithPerson(id);
  }

  creatMessageWithPerson(String id) async {
    try {
      String uid = authMethods.user.uid;
      var allMessage = await firestore.collection('messages').get();
      int check = 0;
      for (var item in allMessage.docs) {
        Message data = Message.fromSnap(item);
        check = (data.groupOrWithPerson == 0 &&
                data.listUid.contains(uid) &&
                data.listUid.contains(id))
            ? 1
            : check;
      }
      if (check == 0) {
        List listUid = [];
        List username = [];
        List photoUrl = [];
        var userDoc = await firestore.collection('users').get();
        for (var item in userDoc.docs) {
          User data = User.fromSnap(item);
          if (data.uid == id || data.uid == uid) {
            listUid.add(data.uid);
            username.add(data.username);
            photoUrl.add(data.photoUrl);
          }
        }
        Message mess = Message(
          id: "message ${allMessage.docs.length}",
          messNearest: "Don\t have mess Nearest",
          groupOrWithPerson: 0,
          photoGroup_member: "",
          listUid: listUid,
          username: username,
          photoUrl: photoUrl,
          colorOfchat: 8,
          nameOfGroup: "",
        );

        _message.value = mess.toJson();
        await firestore
            .collection('messages')
            .doc("message ${allMessage.docs.length}")
            .set(mess.toJson());
        update();
      } else {
        return;
      }
    } catch (err) {
      print(err.toString());
    }
  }

  int getIndexUserInList(String id, List listMem) {
    int index = 0;
    for (var item in listMem) {
      if (item == id) {
        return index;
      }
      index++;
    }
    return index;
  }

  updateNoti(String uid) {
    _uid.value = uid;
    getDataNoti();
  }

  getDataNoti() async {
    _allNoti.bindStream(
      firestore.collection('noti').snapshots().map(
        (event) {
          List<Noti> result = [];
          for (var item in event.docs) {
            Noti noti = Noti.fromSnap(item);
            if (noti.uidRec == _uid.value && noti.typeNoti == 0) {
              result.add(noti);
            }
          }
          return result;
        },
      ),
    );
  }
}
