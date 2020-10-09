import 'package:flutter/material.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Text(data.userUID()),
      ),
    );
  }
}
