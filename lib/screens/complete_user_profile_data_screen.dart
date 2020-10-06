import 'package:flutter/material.dart';

class CompleteUserProfileDataScreen extends StatefulWidget {
  @override
  _CompleteUserProfileDataScreenState createState() =>
      _CompleteUserProfileDataScreenState();
}

class _CompleteUserProfileDataScreenState
    extends State<CompleteUserProfileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Complete your profile data'),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildImageProfile(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildImageProfile(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FlatButton(
          onPressed: () {},
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 100 * 5),
            width: MediaQuery.of(context).size.width / 100 * 40,
            height: MediaQuery.of(context).size.width / 100 * 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage("assets/ben-sweet-2LowviVHZ-E-unsplash.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(90),
              ),
              boxShadow: [BoxShadow(
                blurRadius: 7,
                color: Colors.black38,
              ),],
            ),
          ),
        ),
      ],
    );
  }
}
