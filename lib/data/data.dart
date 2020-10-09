import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

// firestore section
Stream<QuerySnapshot> loadUsersCollectionByUserId(String uid) {
  return fireStore.collection('users').where('uid', isEqualTo: uid).snapshots();
}

Future<void> uploadUserProfileByUserId(String uid, String name, String address,
    String phone, String imageProfile, String email) {
  var data = <String, dynamic>{
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'imageProfile': imageProfile,
  };
  return fireStore.collection('users').doc(uid).set(data);
}

// auth section
Future<void> userSignOut() {
  return auth.signOut();
}

String userPhoneNumber() => auth.currentUser.phoneNumber;

String userUID() => auth.currentUser.uid;

// storage section
StorageReference storageReference() => storage.ref();
