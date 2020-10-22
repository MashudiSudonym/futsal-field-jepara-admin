import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/futsal_field.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';
import 'package:lottie/lottie.dart';

class FieldInformationScreen extends StatefulWidget {
  @override
  _FieldInformationScreenState createState() => _FieldInformationScreenState();
}

class _FieldInformationScreenState extends State<FieldInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Lapangan'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: data.loadFutsalField(data.userUID()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Lottie.asset(
                'assets/nodata.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset(
                'assets/error.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  'assets/nodata.json',
                  height: MediaQuery.of(context).size.height / 100 * 25,
                ),
              );
            default:
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var _futsalField =
                      FutsalFields.fromMap(snapshot.data.docs[index].data());

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 375),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 100 * 3,
                          ),
                          child: Card(
                            elevation: 4.0,
                            child: ListTile(
                              onTap: () {},
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Hero(
                                    tag: _futsalField.uid,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                25,
                                        imageUrl: _futsalField.image,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: FaIcon(
                                            FontAwesomeIcons
                                                .exclamationTriangle,
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          100 *
                                          1,
                                    ),
                                    child: Text(
                                      _futsalField.name.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                _futsalField.address.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ExtendedNavigator.root.push(Routes.addNewFieldScreen);
        },
        tooltip: 'tambah lapangan baru',
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
