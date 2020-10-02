import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_field_jepara_admin/models/user.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

Stream<QuerySnapshot> loadUsersCollectionByUserId(String uid) {
  return _fireStore
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots();
}
