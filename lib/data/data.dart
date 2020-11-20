import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

//// firestore section

//// create new futsal field
void createNewFutsalField(
  String owner,
  String image,
  String name,
  String address,
  String phone,
  int numberOfField,
  String openHour,
  String closeHour,
  int numberOfFieldFlooring,
  int priceDayFlooring,
  int priceNightFlooring,
  int numberOfFieldSynthesis,
  int priceDaySynthesis,
  int priceNightSynthesis,
  double locationLat,
  double locationLong,
) {
  var uid = fireStore.collection('futsalFields').doc().id;
  var futsalFieldData = <String, dynamic>{
    'uid': uid,
    'owner': owner,
    'name': name,
    'address': address,
    'phone': phone,
    'numberOfField': numberOfField,
    'image': image,
    'location': GeoPoint(locationLat, locationLong),
    'openingHours': openHour,
    'closingHours': closeHour,
    'fieldTypeFlooring': '/futsalFields/$uid/fieldType/flooring',
    'fieldTypeSynthesis': '/futsalFields/$uid/fieldType/synthesis',
  };
  var flooringData = <String, dynamic>{
    'uid': 'flooring',
    'numberOfField': numberOfFieldFlooring,
    'priceDay': priceDayFlooring,
    'priceNight': priceNightFlooring,
    'name': 'Flooring'
  };
  var synthesisData = <String, dynamic>{
    'uid': 'synthesis',
    'numberOfField': numberOfFieldSynthesis,
    'priceDay': priceDaySynthesis,
    'priceNight': priceNightSynthesis,
    'name': 'Synthesis'
  };

  fireStore.collection('futsalFields').doc(uid).set(futsalFieldData);
  fireStore
      .collection('futsalFields/$uid/fieldType')
      .doc('flooring')
      .set(flooringData);
  fireStore
      .collection('futsalFields/$uid/fieldType')
      .doc('synthesis')
      .set(synthesisData);
}

//// get schedule data
Future<QuerySnapshot> getScheduleData(
    String futsalFieldUID, String date, String time) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/schedule/')
      .where('date', isEqualTo: date)
      .where('startTime', isEqualTo: time)
      .get();
}

//// update image
Future<void> updateImageFutsalField(String futsalFieldUID, String downloadURL) {
  return fireStore
      .collection('futsalFields/')
      .doc(futsalFieldUID)
      .update({'image': downloadURL});
}

//// update location marker
Future<void> updateLocationMarker(
    String futsalFieldUID, double latitude, double longitude) {
  return fireStore
      .collection('futsalFields/')
      .doc(futsalFieldUID)
      .update({'location': GeoPoint(latitude, longitude)});
}

//// update basic information
Future<void> updateBasicInformation(String futsalFieldUID, String futsalName,
    String futsalAddress, String futsalPhone) {
  return fireStore.collection('futsalFields/').doc(futsalFieldUID).update({
    'name': futsalName,
    'address': futsalAddress,
    'phone': futsalPhone,
  });
}

//// update closing hour
Future<void> updateClosingHour(String futsalFieldUID, String closingHour) {
  return fireStore
      .collection('futsalFields/')
      .doc(futsalFieldUID)
      .update({'closingHours': closingHour});
}

//// update opening hour
Future<void> updateOpeningHour(String futsalFieldUID, String openingHour) {
  return fireStore
      .collection('futsalFields/')
      .doc(futsalFieldUID)
      .update({'openingHours': openingHour});
}

//// update synthesis night price
Future<void> updateSynthesisNightPrice(String futsalFieldUID, int nightPrice) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('synthesis')
      .update({'priceNight': nightPrice});
}

//// update synthesis day price
Future<void> updateSynthesisDayPrice(String futsalFieldUID, int dayPrice) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('synthesis')
      .update({'priceDay': dayPrice});
}

//// update flooring night price
Future<void> updateFlooringNightPrice(String futsalFieldUID, int nightPrice) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('flooring')
      .update({'priceNight': nightPrice});
}

//// update flooring day price
Future<void> updateFlooringDayPrice(String futsalFieldUID, int dayPrice) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('flooring')
      .update({'priceDay': dayPrice});
}

//// update number of field synthesis
Future<void> updateNumberOfFieldSynthesis(
    String futsalFieldUID, int numberOfField) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('synthesis')
      .update({'numberOfField': numberOfField});
}

//// update number of field flooring
Future<void> updateNumberOfFieldFlooring(
    String futsalFieldUID, int numberOfField) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/fieldType/')
      .doc('flooring')
      .update({'numberOfField': numberOfField});
}

//// remove schedule
Future<void> deleteSchedule(String scheduleUID, String futsalFieldUID) {
  return fireStore
      .collection('futsalFields/$futsalFieldUID/schedule')
      .doc(scheduleUID)
      .delete();
}

//// upload schedule
Future<void> createSchedule(String scheduleUID, String futsalFieldUID,
    String fieldType, String name, String date, String time) {
  var data = <String, dynamic>{
    'bookBy': name,
    'booked': true,
    'date': date,
    'fieldType': fieldType,
    'startTime': time,
    'uid': scheduleUID,
  };

  return fireStore
      .collection('futsalFields/$futsalFieldUID/schedule')
      .doc(scheduleUID)
      .set(data);
}

//// get field detail information
Future<DocumentSnapshot> loadFieldDetailInformation(String reference) {
  return fireStore.doc(reference).get();
}

//// update order status on user order
Future<void> updateOrderStatusByOrderUID(String orderUID, int orderStatus) {
  return fireStore
      .collection('userOrders')
      .doc(orderUID)
      .update({'orderStatus': orderStatus});
}

//// get detail of user order by user order id
Future<DocumentSnapshot> loadOrderDetailByOrderUID(String orderUID) {
  return fireStore.collection('userOrders').doc(orderUID).get();
}

//// get detail of futsal field by futsal field UID
Future<DocumentSnapshot> loadFutsalFieldDetailByFutsalFieldUID(
    String futsalFieldUID) {
  return fireStore.collection('futsalFields').doc(futsalFieldUID).get();
}

//// get futsal field list by owner id (active user sign in on this application)
Stream<QuerySnapshot> loadFutsalField(String ownerUID) {
  return fireStore
      .collection('futsalFields')
      .where('owner', isEqualTo: ownerUID)
      .snapshots();
}

//// get id of futsal field by owner id (active user sign in on this application)
Future<QuerySnapshot> loadFutsalFieldUID(String ownerUID) {
  return fireStore
      .collection('futsalFields')
      .where('owner', isEqualTo: ownerUID)
      .limit(1)
      .get();
}

//// get user order data by futsal field id real time
//// if order more than one order, this result is list of orders by futsal field id
Stream<QuerySnapshot> loadUserOrder(String futsalUID) {
  return fireStore
      .collection('userOrders')
      .where('futsalFieldUID', isEqualTo: futsalUID)
      .snapshots();
}

//// load users data by user id real time
//// if user more than one, this result is list of user by id
Stream<QuerySnapshot> loadUsersCollectionByUserId(String uid) {
  return fireStore.collection('users').where('uid', isEqualTo: uid).snapshots();
}

//// upload user profile data by user id
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

//// update user profile data by user id
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

//// get user profile data by user id
Future<DocumentSnapshot> loadUserProfileDataByUserId(String uid) {
  return fireStore.collection('users').doc(uid).get();
}

//// auth section
//// user sigh out
Future<void> userSignOut() => auth.signOut();

//// get user phone number
String userPhoneNumber() => auth.currentUser.phoneNumber;

//// get user uid
String userUID() => auth.currentUser.uid;

//// storage section

//// firebase storage reference initialize
StorageReference storageReference() => storage.ref();
