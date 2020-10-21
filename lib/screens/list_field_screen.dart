import 'package:flutter/material.dart';

class ListFieldScreen extends StatefulWidget {
  @override
  _ListFieldScreenState createState() => _ListFieldScreenState();
}

class _ListFieldScreenState extends State<ListFieldScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Lapangan'),
      ),
      body: Center(
        child: Text('Daftar Lapangan'),
      ),
    );
  }
}
