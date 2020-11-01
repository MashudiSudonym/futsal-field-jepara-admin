import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/models/field_type.dart';
import 'package:futsal_field_jepara_admin/models/futsal_field.dart';
import 'package:lottie/lottie.dart';
import 'package:supercharged/supercharged.dart';

class FieldDetailInformationScreen extends StatefulWidget {
  final String futsalFieldUID;

  const FieldDetailInformationScreen({@required this.futsalFieldUID});
  @override
  _FieldDetailInformationScreenState createState() =>
      _FieldDetailInformationScreenState();
}

class _FieldDetailInformationScreenState
    extends State<FieldDetailInformationScreen> {
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

  @override
  void initState() {
    _loadFutsalFieldDetail();
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
              child: Lottie.asset(
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
            child: Lottie.asset(
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
            _widgetEditButton('Ubah Informasi Dasar'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 2,
            ),
            // Location
            _widgetTextTitle(context, 'Lokasi'),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 100 * 25,
                color: Colors.grey,
              ),
            ),
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

            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 100 * 2,
                right: MediaQuery.of(context).size.height / 100 * 2,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 100 * 5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                ),
                onPressed: () {},
                child: Text('Masukkan Jadwal Lapangan'),
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
                onTap: () {},
              ),
              DataCell(
                Text('Rp $_flooringDayPrice'),
                showEditIcon: true,
                onTap: () {},
              ),
              DataCell(
                Text('Rp $_flooringNightPrice'),
                showEditIcon: true,
                onTap: () {},
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
                onTap: () {},
              ),
              DataCell(
                Text('Rp $_synthesisDayPrice'),
                showEditIcon: true,
                onTap: () {},
              ),
              DataCell(
                Text('Rp $_synthesisNightPrice'),
                showEditIcon: true,
                onTap: () {},
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
