import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: AnimationLimiter(
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
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
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              homeMenu[index].icon,
              size: MediaQuery.of(context).size.width / 100 * 15,
              color: Colors.blueAccent[400],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
