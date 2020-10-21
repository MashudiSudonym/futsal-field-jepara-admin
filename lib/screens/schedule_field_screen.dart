import 'package:flutter/material.dart';

class ScheduleFieldScreen extends StatefulWidget {
  @override
  _ScheduleFieldScreenState createState() => _ScheduleFieldScreenState();
}

class _ScheduleFieldScreenState extends State<ScheduleFieldScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Lapangan'),
      ),
      body: Center(
        child: Text('Jadwal Lapangan'),
      ),
    );
  }
}
