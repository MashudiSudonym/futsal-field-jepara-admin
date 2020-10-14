import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/home_menu.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserProfileData();
  }

  void _checkUserProfileData() {
    final _userID = data.auth.currentUser;
    final _userRootSnapshot = data.loadUsersCollectionByUserId(_userID.uid);

    _userRootSnapshot.listen((event) {
      if (event.docs.isEmpty) {
        ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.completeUserProfileDataScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Futsal Field Jepara - Admin',
        ),
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          itemCount: homeMenu.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.bottom -
                    kToolbarHeight),
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: Duration(milliseconds: 375),
              child: ScaleAnimation(
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
        onTap: () async {
          switch (homeMenu[index].id) {
            case 1:
              await ExtendedNavigator.root.push(Routes.fieldInformationScreen);
              break;
            case 2:
              await ExtendedNavigator.root.push(Routes.orderScreen);
              break;
            case 3:
              await ExtendedNavigator.root.push(Routes.userProfileScreen);
              break;
            case 4:
              await data.userSignOut().whenComplete(() {
                ExtendedNavigator.root
                    .pushAndRemoveUntil(Routes.signInScreen, (route) => false);
              });
              break;
            default:
          }
        },
        child: Container(
          color: homeMenu[index].color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                homeMenu[index].icon,
                size: MediaQuery.of(context).size.width / 100 * 15,
                color: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2.8,
              ),
              Text(
                homeMenu[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
