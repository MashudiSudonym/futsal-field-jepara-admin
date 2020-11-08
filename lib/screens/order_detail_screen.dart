import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/user_order.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:supercharged/supercharged.dart';
import 'package:velocity_x/velocity_x.dart' hide IntExtension;

class OrderDetailScreen extends StatefulWidget {
  final String uid;

  const OrderDetailScreen({@required this.uid});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];

  @override
  void initState() {
    super.initState();

    _printerManager.scanResults.listen((devices) async {
      setState(() {
        _devices = devices;
      });
    });
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    _printerManager.startScan(4.seconds);
    _widgetShowDialogLoading(context);
  }

  void _stopScanDevices() {
    _printerManager.stopScan();
    ExtendedNavigator.root.pop();
  }

  Future<Ticket> ticketFormat(PaperSize paper) async {
    final ticket = Ticket(paper);
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy H:m');
    final timestamp = formatter.format(now);

    ticket.text(
      'FutsalField\nJepara',
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    ticket.text(
      timestamp,
      styles: PosStyles(align: PosAlign.center),
    );

    ticket.hr();

    await data.loadOrderDetailByOrderUID(widget.uid).then((value) {
      var _userOrderData = UserOrder.fromMap(value.data());

      ticket.text(
        'Pemesan : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        _userOrderData.userName,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.text(
        'Tanggal Pesan : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        _userOrderData.orderDate,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.text(
        'Lapangan Dipesan untuk Jam : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        _userOrderData.orderTime,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.text(
        'Nama Lapangan : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        _userOrderData.futsalFieldName,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.text(
        'Jenis Lapangan : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        _userOrderData.fieldType,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.text(
        'Status Pemesanan : ',
        styles: PosStyles(
          align: PosAlign.left,
        ),
      );
      ticket.text(
        (_userOrderData.orderStatus == 2)
            ? 'Pesanan Dibatalkan'
            : (_userOrderData.orderStatus != 0)
                ? 'Pesanan Diterima'
                : 'Menunggu konfirmasi',
        styles: PosStyles(
          align: PosAlign.right,
        ),
      );
      ticket.hr();
      ticket.text(
        'Total Harga : ',
        styles: PosStyles(
          align: PosAlign.left,
          width: PosTextSize.size2,
          height: PosTextSize.size2,
        ),
      );
      ticket.text(
        'Rp. ${_userOrderData.price}',
        styles: PosStyles(
          align: PosAlign.right,
          width: PosTextSize.size2,
          height: PosTextSize.size2,
        ),
      );
    });

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  void _printTicket(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);

    const paper = PaperSize.mm80;

    final res = await _printerManager.printTicket(await ticketFormat(paper)).then((value) {
      ExtendedNavigator.root.pop();
    }).catchError((error) {
      print('Log : $error');
      ExtendedNavigator.root.pop();
    });

    print(res.msg);
  }

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

  SingleChildScrollView _widgetMainContent(BuildContext context, UserOrder _userOrder) {
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
                      : 'Menunggu konfirmasi',
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
                : () async {
                    _startScanDevices();
                    await 4.seconds.delay.then((value) {
                      _stopScanDevices();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Daftar Printer',
                                textAlign: TextAlign.center,
                              ),
                              content: Container(
                                width: 200,
                                height: 200,
                                child: ListView.builder(
                                  itemCount: _devices.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            _printTicket(_devices[index]);
                                          },
                                          title: Text(_devices[index].name),
                                          leading: FaIcon(FontAwesomeIcons.print),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                    });
                  },
      ),
    );
  }

  Future _widgetShowDialogLoading(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            width: 300,
            height: 300,
            child: Center(
              child: Lottie.asset(
                'assets/loading.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            ),
          );
        });
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
                      var close = context.showLoading(msg: 'updating data...');
                      Future.delayed(4.seconds, close).then((value) {
                        data.updateOrderStatusByOrderUID(widget.uid, 2).then((value) {
                          data.deleteSchedule(
                            '${_userOrder.userName}69${_userOrder.uid}${_userOrder.fieldType}${_userOrder.futsalFieldUID}',
                            _userOrder.futsalFieldUID,
                          );
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.SCALE,
                            title: 'Pesanan Dibatalkan',
                            desc: 'Pesanan ini telah dibatalkan oleh admin.',
                            btnOkOnPress: () {
                              ExtendedNavigator.root.pop();
                            },
                          )..show();
                        }).catchError((error) {
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
                          var close = context.showLoading(msg: 'updating data...');
                          Future.delayed(4.seconds, close).then((value) {
                            data.updateOrderStatusByOrderUID(widget.uid, 1).then((value) {
                              data.createSchedule(
                                '${_userOrder.userName}69${_userOrder.uid}${_userOrder.fieldType}${_userOrder.futsalFieldUID}',
                                _userOrder.futsalFieldUID,
                                _userOrder.fieldType,
                                _userOrder.userName,
                                _userOrder.orderDate,
                                _userOrder.orderTime,
                              );
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.SCALE,
                                title: 'Pesanan Diterima',
                                desc: 'Pesanan ini telah diterima oleh admin.',
                                btnOkOnPress: () {
                                  ExtendedNavigator.root.pop();
                                },
                              )..show();
                            }).catchError((error) {
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
