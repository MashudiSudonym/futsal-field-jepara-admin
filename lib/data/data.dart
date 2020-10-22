import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

// firestore section
// get detail of user order by user order id
Future<DocumentSnapshot> loadOrderDetailByOrderUID(String orderUID) {
  return fireStore.collection('userOrders').doc(orderUID).get();
}

// get futsal field list by owner id (active user sign in on this application)
Stream<QuerySnapshot> loadFutsalField(String ownerUID) {
  return fireStore
      .collection('futsalFields')
      .where('owner', isEqualTo: ownerUID)
      .snapshots();
}

// get id of futsal field by owner id (active user sign in on this application)
Future<QuerySnapshot> loadFutsalFieldUID(String ownerUID) {
  return fireStore
      .collection('futsalFields')
      .where('owner', isEqualTo: ownerUID)
      .limit(1)
      .get();
}

// get user order data by futsal field id real time
// if order more than one order, this result is list of orders by futsal field id
Stream<QuerySnapshot> loadUserOrder(String futsalUID) {
  return fireStore
      .collection('userOrders')
      .where('futsalFieldUID', isEqualTo: futsalUID)
      .snapshots();
}

// load users data by user id real time
// if user more than one, this result is list of user by id
Stream<QuerySnapshot> loadUsersCollectionByUserId(String uid) {
  return fireStore.collection('users').where('uid', isEqualTo: uid).snapshots();
}

// upload user profile data by user id
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

// update user profile data by user id
Future<void> updateUserProfileByUserId(String uid, String name, String address,
    String phone, String imageProfile, String email) {
  var data = <String, dynamic>{
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'imageProfile': imageProfile,
  };
  return fireStore.collection('users').doc(uid).update(data);
}

// get user profile data by user id
Future<DocumentSnapshot> loadUserProfileDataByUserId(String uid) {
  return fireStore.collection('users').doc(uid).get();
}

// auth section
// user sigh out
Future<void> userSignOut() => auth.signOut();

// get user phone number
String userPhoneNumber() => auth.currentUser.phoneNumber;

// get user uid
String userUID() => auth.currentUser.uid;

// storage section

// firebase storage reference initialize
StorageReference storageReference() => storage.ref();
