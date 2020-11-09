import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/field_type.dart';
import 'package:futsal_field_jepara_admin/models/futsal_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:supercharged/supercharged.dart';
import 'package:velocity_x/velocity_x.dart' hide IntExtension;

class FieldDetailInformationScreen extends StatefulWidget {
  final String futsalFieldUID;

  const FieldDetailInformationScreen({@required this.futsalFieldUID});

  @override
  _FieldDetailInformationScreenState createState() =>
      _FieldDetailInformationScreenState();
}

class _FieldDetailInformationScreenState
    extends State<FieldDetailInformationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kInitialPositiion = const CameraPosition(
    target: LatLng(-6.649179, 110.707172),
    zoom: 18.0,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _datePickerController = TextEditingController();
  String _dateValue = '';
  DateTime _date = DateTime.now();
  TextEditingController _startTimePickerController = TextEditingController();
  String _startTimeValue = '';
  TimeOfDay _startTime = TimeOfDay.now();
  int _flooringQuantity;
  int _flooringDayPrice;
  int _flooringNightPrice;
  int _synthesisQuantity;
  int _synthesisDayPrice;
  int _synthesisNightPrice;
  bool visible = false;
  double _latitude = -6.649179;
  double _longitude = 110.707172;
  final Set<Marker> _markers = {};
  Marker _marker;

  @override
  void initState() {
    _loadFutsalFieldDetail();
    _animateCameraToLocation();
    _addMarker();
    super.initState();
  }

  Future<void> _loadFutsalFieldDetail() async {
    await 1.seconds.delay.then((value) {
      data
          .loadFutsalFieldDetailByFutsalFieldUID(widget.futsalFieldUID)
          .then((snapshot) {
        var _futsalField = FutsalFields.fromMap(snapshot.data());

        var _fieldFlooring =
            data.loadFieldDetailInformation(_futsalField.fieldTypeFlooring);
        var _fieldSynthesis =
            data.loadFieldDetailInformation(_futsalField.fieldTypeSynthesis);

        setState(() {
          _latitude = _futsalField.location.latitude;
          _longitude = _futsalField.location.longitude;
        });

        _fieldFlooring.then((value) {
          var _fieldType = FieldType.fromMap(value.data());

          setState(() {
            _flooringQuantity = _fieldType.numberOfField;
            _flooringDayPrice = _fieldType.priceDay;
            _flooringNightPrice = _fieldType.priceNight;
          });
        });

        _fieldSynthesis.then((value) {
          var _fieldType = FieldType.fromMap(value.data());

          setState(() {
            _synthesisQuantity = _fieldType.numberOfField;
            _synthesisDayPrice = _fieldType.priceDay;
            _synthesisNightPrice = _fieldType.priceNight;
          });
        });
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    var _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1945),
      lastDate: DateTime(2222),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        _dateValue = _date.toString().split(' ')[0];
        _datePickerController = TextEditingController(text: _dateValue);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    var _timePicker = await showTimePicker(
      context: context,
      initialTime: _startTime,
      helpText: 'Masukkan jam dan menit dahulu, setelah itu tekan ok',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child,
        );
      },
    );

    if (_timePicker != null && _timePicker != _startTime) {
      setState(() {
        _startTime = _timePicker;
        _startTimeValue = _startTime.format(context);
        _startTimePickerController =
            TextEditingController(text: _startTimeValue);
      });
    }
  }

  Future<void> _animateCameraToLocation() async {
    final controller = await _controller.future;

    setState(() {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_latitude, _longitude),
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  Future<void> _addMarker() async {
    _marker = Marker(
      flat: true,
      position: LatLng(_latitude, _longitude),
      markerId: MarkerId('name'),
    );

    setState(() {
      _markers.add(_marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Informasi Lapangan'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            data.loadFutsalFieldDetailByFutsalFieldUID(widget.futsalFieldUID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: lottie.Lottie.asset(
                'assets/error.json',
                height: MediaQuery.of(context).size.height / 100 * 25,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var _futsalField = FutsalFields.fromMap(snapshot.data.data());

            return _widgetLayout(context, _futsalField);
          }
          return Center(
            child: lottie.Lottie.asset(
              'assets/loading.json',
              height: MediaQuery.of(context).size.height / 100 * 25,
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView _widgetLayout(
      BuildContext context, FutsalFields _futsalField) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo Futsal Field
            Hero(
              tag: _futsalField.uid,
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 100 * 25,
                imageUrl: _futsalField.image,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: RaisedButton.icon(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.photoVideo,
                  color: Colors.white,
                ),
                label: Text(
                  'Ganti Foto Lapangan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height / 100 * 1.2,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // Basic Information
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: Text(
                _futsalField.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height / 100 * 2.5,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: Text(
                _futsalField.address,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: Text(
                _futsalField.phone,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: 'Ubah Informasi Dasar'.text.make(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // Location
            _widgetTextTitle(context, 'Lokasi'),
            _widgetMapFieldLocation(context),
            _widgetEditButton('Ubah Lokasi'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // Facilities
            _widgetTextTitle(context, 'Fasilitas'),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: _widgetDataTableFacilities(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // operational time schedule
            _widgetTextTitle(context, 'Jam Operasional'),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100 * 1.5,
                left: MediaQuery.of(context).size.height / 100 * 4,
                right: MediaQuery.of(context).size.height / 100 * 10,
              ),
              child: _widgetTableOperationalTime(context, _futsalField),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // field schedule
            _widgetTextTitle(context, 'Jadwal Lapangan'),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100 * 2,
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: _widgetDateTimeField(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 100 * 2,
                  left: MediaQuery.of(context).size.height / 100 * 2,
                  right: MediaQuery.of(context).size.height / 100 * 2,
                ),
                child: _widgetFieldScheduleTable(context),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
          ],
        ),
      ),
    );
  }

  Padding _widgetMapFieldLocation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height / 100 * 2,
        right: MediaQuery.of(context).size.height / 100 * 2,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 100 * 25,
        color: Colors.grey,
        child: GoogleMap(
          initialCameraPosition: _kInitialPositiion,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          markers: _markers,
        ),
      ),
    );
  }

  Column _widgetFieldScheduleTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Pesan ${_datePickerController.text}',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
          ),
        ),
        Text(
          'Lapangan Dipesan untuk Jam : ${_startTimePickerController.text}',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dividerThickness: 1.0,
            headingTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
            ),
            columns: [
              DataColumn(
                label: Text('Lapangan Flooring'),
              ),
              DataColumn(
                label: Text('Lapangan Sintetis'),
              ),
            ],
            rows: [
              DataRow(cells: [
                DataCell(
                  Text('Mashudi'),
                ),
                DataCell(
                  Text('-'),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Form _widgetDateTimeField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // select date schedule
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'tentukan tanggal pesan lapangan';
              }
              return null;
            },
            onTap: () {
              setState(() {
                _selectDate(context);
              });
            },
            controller: _datePickerController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: '$_dateValue',
              labelText: 'Pilih Tanggal',
              labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 100 * 4,
                color: Colors.blue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100 * 1.5,
          ),
          // select start time schedule
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'tentukan jam mulai pesan lapangan';
              }
              return null;
            },
            onTap: () {
              setState(() {
                _selectStartTime(context);
              });
            },
            controller: _startTimePickerController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: '$_startTimeValue',
              labelText: 'Pilih Jam Mulai',
              labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 100 * 4,
                color: Colors.blue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100 * 1.5,
          ),
          // select finish time schedule

          // button submit
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 100 * 5,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    visible = true;
                  });
                }
              },
              child: Text('Tampil Data'),
            ),
          ),
        ],
      ),
    );
  }

  Table _widgetTableOperationalTime(
      BuildContext context, FutsalFields _futsalField) {
    return Table(
      columnWidths: {
        0: FractionColumnWidth(.3),
        1: FractionColumnWidth(.1),
        2: FractionColumnWidth(.2),
        3: FractionColumnWidth(.4),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: _widgetTextContentTable(context, 'Jam Buka'),
            ),
            TableCell(
              child: _widgetTextContentTable(context, ':'),
            ),
            TableCell(
              child:
                  _widgetTextContentTable(context, _futsalField.openingHours),
            ),
            TableCell(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: _widgetTextContentTable(context, 'Jam Tutup'),
            ),
            TableCell(
              child: _widgetTextContentTable(context, ':'),
            ),
            TableCell(
              child:
                  _widgetTextContentTable(context, _futsalField.closingHours),
            ),
            TableCell(
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text _widgetTextContentTable(BuildContext context, String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
      ),
    );
  }

  SingleChildScrollView _widgetDataTableFacilities(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dividerThickness: 1.0,
        headingTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height / 100 * 1.8,
        ),
        columns: [
          DataColumn(
            label: Text(
              'Jenis Lapangan',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Jumlah',
            ),
          ),
          DataColumn(
            label: Text(
              'Harga Pagi',
            ),
          ),
          DataColumn(
            label: Text(
              'Harga Malam',
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(
                Text('Lapangan Flooring'),
              ),
              DataCell(
                Center(
                  child: Text('$_flooringQuantity'),
                ),
                showEditIcon: true,
                onTap: () {
                  var _numberOfFieldFlooring = TextEditingController();
                  _numberOfFieldFlooring.text = _flooringQuantity.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Jumlah lapangan yang tersedia : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _flooringQuantity.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _numberOfFieldFlooring,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateNumberOfFieldFlooring(
                                          widget.futsalFieldUID,
                                          _numberOfFieldFlooring.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
              DataCell(
                Text('Rp $_flooringDayPrice'),
                showEditIcon: true,
                onTap: () {
                  var _dayPriceFlooring = TextEditingController();
                  _dayPriceFlooring.text = _flooringDayPrice.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Harga sewa lapangan (Pagi) : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _flooringDayPrice.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _dayPriceFlooring,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateFlooringDayPrice(
                                          widget.futsalFieldUID,
                                          _dayPriceFlooring.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
              DataCell(
                Text('Rp $_flooringNightPrice'),
                showEditIcon: true,
                onTap: () {
                  var _nightPriceFlooring = TextEditingController();
                  _nightPriceFlooring.text = _flooringNightPrice.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Harga sewa lapangan (Malam) : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _flooringNightPrice.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _nightPriceFlooring,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateFlooringNightPrice(
                                          widget.futsalFieldUID,
                                          _nightPriceFlooring.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text('Lapangan Sintetis'),
              ),
              DataCell(
                Center(
                  child: Text('$_synthesisQuantity'),
                ),
                showEditIcon: true,
                onTap: () {
                  var _numberOfFieldSynthesis = TextEditingController();
                  _numberOfFieldSynthesis.text = _synthesisQuantity.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Jumlah lapangan yang tersedia : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _synthesisQuantity.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _numberOfFieldSynthesis,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateNumberOfFieldSynthesis(
                                          widget.futsalFieldUID,
                                          _numberOfFieldSynthesis.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
              DataCell(
                Text('Rp $_synthesisDayPrice'),
                showEditIcon: true,
                onTap: () {
                  var _dayPriceSynthesis = TextEditingController();
                  _dayPriceSynthesis.text = _synthesisDayPrice.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Harga sewa lapangan (Pagi) : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _synthesisDayPrice.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _dayPriceSynthesis,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateSynthesisDayPrice(
                                          widget.futsalFieldUID,
                                          _dayPriceSynthesis.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
              DataCell(
                Text('Rp $_synthesisNightPrice'),
                showEditIcon: true,
                onTap: () {
                  var _nightPriceSynthesis = TextEditingController();
                  _nightPriceSynthesis.text = _synthesisNightPrice.toString();

                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: [
                            'Harga sewa lapangan (Malam) : '.text.lg.make(),
                            10.heightBox,
                            VxTextField(
                              value: _synthesisNightPrice.toString(),
                              borderType: VxTextFieldBorderType.roundLine,
                              keyboardType: TextInputType.number,
                              fillColor: Vx.white,
                              controller: _nightPriceSynthesis,
                            ),
                            25.heightBox,
                            [
                              ElevatedButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: 'Batal'.text.make(),
                              ),
                              10.widthBox,
                              ElevatedButton(
                                onPressed: () async {
                                  var close = context.showLoading(
                                      msg: 'update data...');
                                  await Future.delayed(3.seconds, close).then(
                                      (value) => ExtendedNavigator.root.pop());
                                  await data
                                      .updateSynthesisNightPrice(
                                          widget.futsalFieldUID,
                                          _nightPriceSynthesis.text.toInt())
                                      .then(
                                          (value) => _loadFutsalFieldDetail());
                                },
                                child: 'Oke'.text.black.make(),
                                style:
                                    ElevatedButton.styleFrom(primary: Vx.white),
                              ),
                            ].hStack().box.alignCenterRight.make(),
                          ]
                              .vStack(crossAlignment: CrossAxisAlignment.start)
                              .scrollVertical()
                              .box
                              .p16
                              .height(context.percentHeight * 20)
                              .make(),
                        );
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _widgetEditButton(String buttonText) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(buttonText),
      ),
    );
  }

  Container _widgetTextTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height / 100 * 2,
        right: MediaQuery.of(context).size.height / 100 * 2,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.height / 100 * 2.5,
        ),
      ),
    );
  }
}
