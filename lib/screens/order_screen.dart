import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/futsal_field.dart';
import 'package:futsal_field_jepara_admin/models/user_order.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String futsalUID = '';

  @override
  void initState() {
    _getFutsalUID();

    super.initState();
  }

  void _getFutsalUID() {
    data.loadFutsalFieldUID(data.userUID()).then((snapshot) {
      snapshot.docs.forEach((element) {
        var futsal = FutsalFields.fromMap(element.data());

        setState(() {
          futsalUID = futsal.uid;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Masuk'),
      ),
      body: futsalUID == ''
          ? Center(
              child: Lottie.asset(
                'assets/loading.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: data.loadUserOrder(futsalUID),
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
                        var _userOrder =
                            UserOrder.fromMap(snapshot.data.docs[index].data());

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
                                    title: Text(
                                      _userOrder.userName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                5.5,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width /
                                            100 *
                                            3,
                                      ),
                                      child: Text(
                                        (_userOrder.orderStatus != 0)
                                            ? "Lapangan : ${_userOrder.futsalFieldName}\nTanggal Pesan : ${_userOrder.orderDate.replaceAll("-", "/")}\nJam Pesan : ${_userOrder.orderTime}\nJenis Lapangan : ${_userOrder.fieldType}\nHarga : Rp.${_userOrder.price}\nStatus Pesanan : Pesanan Diterima"
                                            : "Lapangan : ${_userOrder.futsalFieldName}\nTanggal Pesan : ${_userOrder.orderDate.replaceAll("-", "/")}\nJam Pesan : ${_userOrder.orderTime}\nJenis Lapangan : ${_userOrder.fieldType}\nHarga : Rp.${_userOrder.price}\nStatus Pesanan : Menunggu",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              4,
                                        ),
                                      ),
                                    ),
                                    isThreeLine: true,
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
    );
  }
}
