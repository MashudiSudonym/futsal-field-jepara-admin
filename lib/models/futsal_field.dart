import 'package:cloud_firestore/cloud_firestore.dart';

class FutsalFields {
  final String address;
  final String closingHours;
  final String fieldTypeFlooring;
  final String fieldTypeSynthesis;
  final String image;
  final GeoPoint location;
  final String name;
  final int numberOfField;
  final String openingHours;
  final String owner;
  final String phone;
  final String uid;

  FutsalFields.fromMap(Map<String, dynamic> map)
      : assert(map['address'] != null),
        assert(map['closingHours'] != null),
        assert(map['fieldTypeFlooring'] != null),
        assert(map['fieldTypeSynthesis'] != null),
        assert(map['image'] != null),
        assert(map['location'] != null),
        assert(map['name'] != null),
        assert(map['numberOfField'] != null),
        assert(map['openingHours'] != null),
        assert(map['owner'] != null),
        assert(map['phone'] != null),
        assert(map['uid'] != null),
        address = map['address'],
        closingHours = map['closingHours'],
        fieldTypeFlooring = map['fieldTypeFlooring'],
        fieldTypeSynthesis = map['fieldTypeSynthesis'],
        image = map['image'],
        location = map['location'],
        name = map['name'],
        numberOfField = map['numberOfField'],
        openingHours = map['openingHours'],
        owner = map['owner'],
        phone = map['phone'],
        uid = map['uid'];

  FutsalFields.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data(),
        );
}
