import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String address;
  final String email;
  final String imageProfile;
  final String name;
  final String phone;
  final String uid;

  User.fromMap(Map<String, dynamic> map)
      : assert(map['address'] != null),
        assert(map['email'] != null),
        assert(map['imageProfile'] != null),
        assert(map['name'] != null),
        assert(map['phone'] != null),
        assert(map['address'] != null),
        address = map['address'],
        email = map['email'],
        imageProfile = map['imageProfile'],
        name = map['name'],
        phone = map['phone'],
        uid = map['uid'];

  User.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data());
}
