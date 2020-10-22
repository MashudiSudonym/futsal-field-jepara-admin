import 'package:flutter/material.dart';

class FieldDetailInformationScreen extends StatefulWidget {
  @override
  _FieldDetailInformationScreenState createState() =>
      _FieldDetailInformationScreenState();
}

class _FieldDetailInformationScreenState
    extends State<FieldDetailInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Informasi Lapangan'),
      ),
      body: Center(
        child: Text('Detail Informasi Lapangan'),
      ),
    );
  }
}
