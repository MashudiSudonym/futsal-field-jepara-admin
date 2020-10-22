import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/user.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';
import 'package:lottie/lottie.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Admin'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: data.loadUserProfileDataByUserId(data.userUID()),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset(
                'assets/error.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/loading.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }

          var userData = User.fromMap(snapshot.data.data());
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width / 100 * 5,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 100 * 20,
                      backgroundImage: (userData.imageProfile != null)
                          ? NetworkImage(userData.imageProfile)
                          : Lottie.asset('assets/loading.json'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100 * 5,
                    ),
                    Text(
                      userData.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width / 100 * 6,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100 * 5,
                    ),
                    _widgetTextIconUserData(
                      context,
                      userData.email,
                      FontAwesomeIcons.solidEnvelope,
                    ),
                    _widgetTextIconUserData(
                      context,
                      userData.address,
                      FontAwesomeIcons.mapMarked,
                    ),
                    _widgetTextIconUserData(
                      context,
                      userData.phone,
                      FontAwesomeIcons.phoneAlt,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100 * 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 100 * 5.5,
                      child: ElevatedButton(
                        child: Text('Ubah Profil'),
                        onPressed: () {
                          ExtendedNavigator.root
                              .push(Routes.editUserProfileScreen);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row _widgetTextIconUserData(
      BuildContext context, String userData, IconData iconData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 100 * 10,
        ),
        FaIcon(
          iconData,
          size: MediaQuery.of(context).size.width / 100 * 4,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 100 * 5,
        ),
        Flexible(
          child: SelectableText(
            userData,
            enableInteractiveSelection: true,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 100 * 4,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 100 * 5,
        ),
      ],
    );
  }
}
