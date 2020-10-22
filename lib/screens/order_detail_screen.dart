import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/user_order.dart';
import 'package:lottie/lottie.dart';

class OrderDetailScreen extends StatefulWidget {
  final String uid;

  const OrderDetailScreen({@required this.uid});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: data.loadOrderDetailByOrderUID(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset(
                'assets/error.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var _userOrder = UserOrder.fromMap(snapshot.data.data());

            return _widgetMainContent(context, _userOrder);
          }
          return Center(
            child: Lottie.asset(
              'assets/loading.json',
              height: MediaQuery.of(context).size.height / 100 * 25,
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView _widgetMainContent(
      BuildContext context, UserOrder _userOrder) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width / 100 * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _widgetTextTitle(context, 'Pemesan'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, _userOrder.userName),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Tanggal Pesan'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, _userOrder.orderDate),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Lapangan Dipesan untuk Jam'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, _userOrder.orderTime),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Nama Lapangan'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, _userOrder.futsalFieldName),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Jenis Lapangan'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, _userOrder.fieldType),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Harga'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(context, 'Rp. ${_userOrder.price}'),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetTextTitle(context, 'Status Pesanan'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            _widgetTextCustomerData(
              context,
              (_userOrder.orderStatus == 2)
                  ? 'Pesanan Dibatalkan'
                  : (_userOrder.orderStatus != 0)
                      ? 'Pesanan Diterima'
                      : 'Menunggu',
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetButtonOrderStatus(_userOrder, context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetPrintButton(context, _userOrder),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
          ],
        ),
      ),
    );
  }

  Container _widgetPrintButton(BuildContext context, UserOrder _userOrder) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 100 * 5.5,
      child: OutlinedButton.icon(
        label: Text('Cetak Struk'),
        icon: FaIcon(FontAwesomeIcons.print),
        onPressed: (_userOrder.orderStatus == 0)
            ? null
            : (_userOrder.orderStatus == 2)
                ? null
                : () {},
      ),
    );
  }

  Row _widgetButtonOrderStatus(UserOrder _userOrder, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Button Cancel Order
        ElevatedButton(
          onPressed: (_userOrder.orderStatus == 2)
              ? null
              : () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.SCALE,
                    title: 'Batalkan Pesanan ?',
                    desc: 'Anda yakin akan membatalkan pesanan ini.',
                    btnOkColor: Colors.red,
                    btnOkOnPress: () {
                      data
                          .updateOrderStatusByOrderUID(widget.uid, 2)
                          .then((value) => {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.SCALE,
                                  title: 'Pesanan Dibatalkan',
                                  desc:
                                      'Pesanan ini telah dibatalkan oleh admin.',
                                  btnOkOnPress: () {
                                    ExtendedNavigator.root.pop();
                                  },
                                )..show()
                              })
                          .catchError((error) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.SCALE,
                          title: 'Terjadi Masalah!',
                          desc: 'Kami mengira koneksi internet anda terganggu.',
                          btnOkOnPress: () {
                            ExtendedNavigator.root.pop();
                          },
                        )..show();
                      });
                    },
                  )..show();
                },
          child: Text('Batalkan Pesanan'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              MediaQuery.of(context).size.height / 100 * 3,
              MediaQuery.of(context).size.height / 100 * 5,
            ),
          ),
        ),
        // Button Accept Order
        ElevatedButton(
          onPressed: (_userOrder.orderStatus == 2)
              ? null
              : (_userOrder.orderStatus == 1)
                  ? null
                  : () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.SCALE,
                        title: 'Terima Pesanan ?',
                        desc: 'Anda yakin akan menerima pesanan ini.',
                        btnOkOnPress: () {
                          data
                              .updateOrderStatusByOrderUID(widget.uid, 1)
                              .then((value) => {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.SUCCES,
                                      animType: AnimType.SCALE,
                                      title: 'Pesanan Diterima',
                                      desc:
                                          'Pesanan ini telah diterima oleh admin.',
                                      btnOkOnPress: () {
                                        ExtendedNavigator.root.pop();
                                      },
                                    )..show()
                                  })
                              .catchError((error) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              animType: AnimType.SCALE,
                              title: 'Terjadi Masalah!',
                              desc:
                                  'Kami mengira koneksi internet anda terganggu.',
                              btnOkOnPress: () {
                                ExtendedNavigator.root.pop();
                              },
                            )..show();
                          });
                        },
                      )..show();
                    },
          child: Text('Terima Pesanan'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            minimumSize: Size(
              MediaQuery.of(context).size.height / 100 * 3,
              MediaQuery.of(context).size.height / 100 * 5,
            ),
          ),
        ),
      ],
    );
  }

  Text _widgetTextCustomerData(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text _widgetTextTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 4.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
