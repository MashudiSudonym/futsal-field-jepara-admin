import 'package:flutter/material.dart';

class AddNewFieldScreen extends StatefulWidget {
  @override
  _AddNewFieldScreenState createState() => _AddNewFieldScreenState();
}

class _AddNewFieldScreenState extends State<AddNewFieldScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Lapangan Baru'),
      ),
      body: Center(
        child: Text('Tambah Lapangan Baru'),
      ),
    );
  }
}
