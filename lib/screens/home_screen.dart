import 'package:flutter/material.dart';
import 'package:futsal_field_jepara_admin/models/home_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Futsal Field Jepara - Admin",
        ),
      ),
      body: GridView.builder(
        itemCount: homeMenu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight),
        ),
        itemBuilder: (context, index) {},
      ),
    );
  }
}
