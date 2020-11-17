import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewFieldScreen extends StatefulWidget {
  @override
  _AddNewFieldScreenState createState() => _AddNewFieldScreenState();
}

class _AddNewFieldScreenState extends State<AddNewFieldScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _futsalNameController = TextEditingController();
  final TextEditingController _futsalAddressController =
      TextEditingController();
  final TextEditingController _futsalPhoneController = TextEditingController();
  final TextEditingController _futsalOpenHourController =
      TextEditingController();
  final TextEditingController _futsalCloseHourController =
      TextEditingController();
  final TextEditingController _futsalNumberOfFieldController =
      TextEditingController(text: '0');
  final TextEditingController _futsalNumberOfFieldFlooringController =
      TextEditingController(text: '0');
  final TextEditingController _futsalNumberOfFieldSynthesisController =
      TextEditingController(text: '0');
  final TextEditingController _futsalPriceDayFlooringController =
      TextEditingController(text: '0');
  final TextEditingController _futsalPriceNightFlooringController =
      TextEditingController(text: '0');
  final TextEditingController _futsalPriceDaySynthesisController =
      TextEditingController(text: '0');
  final TextEditingController _futsalPriceNightSynthesisController =
      TextEditingController(text: '0');
  final TextEditingController _futsalLatitudeController =
      TextEditingController();
  final TextEditingController _futsalLongitudeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _futsalNameController.dispose();
    _futsalAddressController.dispose();
    _futsalCloseHourController.dispose();
    _futsalLatitudeController.dispose();
    _futsalLongitudeController.dispose();
    _futsalNumberOfFieldController.dispose();
    _futsalNumberOfFieldFlooringController.dispose();
    _futsalNumberOfFieldSynthesisController.dispose();
    _futsalPriceDayFlooringController.dispose();
    _futsalPriceDaySynthesisController.dispose();
    _futsalPriceNightFlooringController.dispose();
    _futsalPriceNightSynthesisController.dispose();
    _futsalOpenHourController.dispose();
    _futsalPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Lapangan Baru'),
        ),
        body: VStack([
          // widget image upload
          _widgetImageUpload(),
          20.heightBox,
          // widget form field data
          Form(
            key: _formKey,
            child: VStack([
              'Informasi Dasar'.text.xl3.make(),
              // widget name form field
              TextFormField(
                controller: _futsalNameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Nama Stadion Futsal',
                  hintText: 'Nama Stadion Futsal',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi nama stadion futsal.';
                  }
                  return null;
                },
              ),
              // widget address form field
              TextFormField(
                controller: _futsalAddressController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Alamat Stadion Futsal',
                  hintText: 'Alamat Stadion Futsal',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi alamat stadion futsal.';
                  }
                  return null;
                },
              ),
              // widget phone form field
              TextFormField(
                controller: _futsalPhoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Nomor Telepon Stadion Futsal',
                  hintText: 'Nomor Telepon Stadion Futsal',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi nomor telepon stadion futsal.';
                  }
                  return null;
                },
              ),
              // widget the number of fields form field
              TextFormField(
                controller: _futsalNumberOfFieldController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Jumlah Total Lapangan',
                  hintText: 'Jumlah Total Lapangan',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi jumlah total lapangan.';
                  }
                  return null;
                },
              ),
              // TODO: open and close hour form field
              15.heightBox,
              'Lapangan Flooring'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan flooring'
                  .text
                  .red500
                  .make(),
              15.heightBox,
              'Lapangan Sintetis'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan sintetis'
                  .text
                  .red500
                  .make(),
              15.heightBox,
              'Lokasi Lapangan Futsal'.text.xl3.make(),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () async {
                  const url = 'https://youtu.be/-ZsT77K8ijs';

                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Error cannot launch $url';
                  }
                },
                child:
                    'Tutorial cara mendapatkan nilai latitude dan longitude lokasi, klik disini!'
                        .text
                        .red500
                        .make(),
              ),
              20.heightBox,
              ElevatedButton.icon(
                label: 'Simpan'.text.make(),
                icon: FaIcon(FontAwesomeIcons.save),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(context.percentWidth * 2),
                ),
                onPressed: () {
                  context.showToast(msg: 'data saved');
                },
              ).box.width(double.infinity).make(),
              20.heightBox,
            ]).p16(),
          ),
        ]).scrollVertical(),
      ),
    );
  }

  Widget _widgetImageUpload() {
    return [
      Image(
        image: AssetImage('assets/icon-admin.jpeg'),
      ),
      ElevatedButton.icon(
        onPressed: () {
          // TODO: do choose image and upload command here
        },
        style: ElevatedButton.styleFrom(),
        icon: FaIcon(FontAwesomeIcons.camera),
        label: 'Foto Lapangan'.text.make(),
      )
    ].vStack().box.width(double.infinity).make();
  }
}
