import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  final String fieldType;
  final String futsalFieldName;
  final String futsalFieldUID;
  final String orderDate;
  final int orderStatus;
  final String orderTime;
  final int price;
  final String uid;
  final String userName;
  final String userUID;

  UserOrder.fromMap(Map<String, dynamic> map)
      : assert(map['fieldType'] != null),
        assert(map['futsalFieldName'] != null),
        assert(map['futsalFieldUID'] != null),
        assert(map['orderDate'] != null),
        assert(map['orderStatus'] != null),
        assert(map['orderTime'] != null),
        assert(map['price'] != null),
        assert(map['uid'] != null),
        assert(map['userName'] != null),
        assert(map['userUID'] != null),
        fieldType = map['fieldType'],
        futsalFieldName = map['futsalFieldName'],
        futsalFieldUID = map['futsalFieldUID'],
        orderDate = map['orderDate'],
        orderStatus = map['orderStatus'],
        orderTime = map['orderTime'],
        price = map['price'],
        uid = map['uid'],
        userName = map['userName'],
        userUID = map['userUID'];

  UserOrder.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
