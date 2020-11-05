import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String bookBy;
  final bool booked;
  final String date;
  final String fieldType;
  final String startTime;
  final String uid;

  Schedule.fromMap(Map<String, dynamic> map)
      : assert(map['bookBy'] != null),
        assert(map['booked'] != null),
        assert(map['date'] != null),
        assert(map['fieldType'] != null),
        assert(map['startTime'] != null),
        assert(map['uid'] != null),
        bookBy = map['bookBy'],
        booked = map['booked'],
        date = map['date'],
        fieldType = map['fieldType'],
        startTime = map['startTime'],
        uid = map['uid'];

  Schedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data(),
        );
}
