import 'package:cloud_firestore/cloud_firestore.dart';

class FieldType {
  final String name;
  final int numberOfField;
  final int priceDay;
  final int priceNight;
  final String uid;

  FieldType.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['numberOfField'] != null),
        assert(map['priceDay'] != null),
        assert(map['priceNight'] != null),
        assert(map['uid'] != null),
        name = map['name'],
        numberOfField = map['numberOfField'],
        priceDay = map['priceDay'],
        priceNight = map['priceNight'],
        uid = map['uid'];

  FieldType.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
