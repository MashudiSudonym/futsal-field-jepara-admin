import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/models/field_information_menu.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';

class FieldInformationScreen extends StatefulWidget {
  @override
  _FieldInformationScreenState createState() => _FieldInformationScreenState();
}

class _FieldInformationScreenState extends State<FieldInformationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Informasi Lapangan'),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: fieldInformationMenu.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 375),
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: buildMaterial(
                    index,
                    context,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Material buildMaterial(int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          switch (fieldInformationMenu[index].id) {
            case 1:
              ExtendedNavigator.root.push(Routes.listFieldScreen);
              break;
            case 2:
              ExtendedNavigator.root.push(Routes.scheduleFieldScreen);
              break;
            default:
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 100 * 2,
            bottom: MediaQuery.of(context).size.height / 100 * 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(
                fieldInformationMenu[index].icon,
                size: MediaQuery.of(context).size.width / 100 * 10,
                color: Colors.black,
              ),
              Text(
                fieldInformationMenu[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
