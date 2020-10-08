import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

// firestore section
Stream<QuerySnapshot> loadUsersCollectionByUserId(String uid) {
  return fireStore.collection('users').where('uid', isEqualTo: uid).snapshots();
}

// auth section
Future<void> userSignOut() {
  return auth.signOut();
}

String userPhoneNumber() => auth.currentUser.phoneNumber;

String userUID() => auth.currentUser.uid;
