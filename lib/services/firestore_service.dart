import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/upload.dart';
import '../models/user_model.dart';

class FireStoreService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUsers(UserModel model) async {
    return await _ref.doc(model.userId).set(model.toMap());
  }

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _ref.doc(uid).get();
  }

  Future<void> upload(String userId, FirebaseSend fire, int count) async {
    if (count == 1) {
      return await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .delete();
    } else if (count == 0) {
      return await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .set(fire.toMap());
    }
  }

  Future<bool> heart(String userId, String fire) async {
    var data = await _ref.doc(userId).collection('Favourites').doc(fire).get();

    if (data.data() != null) {
      return true;
    } else {
      return false;
    }
  }

  // check if movie or a show is already in the watchlist
  Future<void> watchList(
      String userId, FirebaseSend fire, String isShow) async {
    await _ref
          .doc(userId)
          .collection('${isShow}WatchList')
          .doc(fire.id)
          .set(fire.toMap());
      // Get.snackbar('Added WatchList In Firebase', '',
      //     duration: const Duration(seconds: 1),
      //     backgroundColor: lightColor,
      //     colorText: whiteColor);
  }

  // Stream<List<FirebaseSend>> getfavourites(String uid) {
  //   List<FirebaseSend> retVal = [];
  //   return _ref
  //       .doc(uid)
  //       .collection("Favourites")
  //       .orderBy("time", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     retVal.clear();
  //     query.docs.forEach((element) {
  //       retVal.add(FirebaseSend.fromDocumentSnapshot(element));
  //       print(element.data());
  //     });
  //     return retVal;
  //   });
  // }

  Future<void> delete(String uid, String id, String collection) async {
    return _ref.doc(uid).collection(collection).doc(id).delete();
  }

  // Stream<List<FirebaseSend>> getUserMessageStream(
  //     String userId, String collection) {
  //   List<FirebaseSend> messages = [];
  //   Stream<QuerySnapshot> snapshots = _ref
  //       .doc(userId)
  //       .collection(collection)
  //       .orderBy("time", descending: true)
  //       .snapshots();
  //   snapshots.listen((QuerySnapshot query) {
  //     if (query.docChanges.isNotEmpty) {
  //       messages.clear();
  //     }
  //   });
  //   return snapshots.map((snapshot) {
  //     snapshot.docs.forEach((messageData) {
  //       messages.add(FirebaseSend.fromDocumentSnapshot(messageData));
  //     });
  //     return messages.toList();
  //   });
  // }
}
