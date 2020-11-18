import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewFieldScreen extends StatefulWidget {
  @override
  _AddNewFieldScreenState createState() => _AddNewFieldScreenState();
}

class _AddNewFieldScreenState extends State<AddNewFieldScreen> {
  double locationLat = -6.633331;
  double locationLong = 110.7173391;
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
      TextEditingController(text: '-6.633331');
  final TextEditingController _futsalLongitudeController =
      TextEditingController(text: '110.7173391');

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
          //// widget image upload
          _widgetImageUpload(),
          20.heightBox,
          //// widget form field data
          Form(
            key: _formKey,
            child: VStack([
              'Informasi Dasar'.text.xl3.make(),
              //// widget name form field
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
              //// widget address form field
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
              //// widget phone form field
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
              //// widget the number of fields form field
              TextFormField(
                controller: _futsalNumberOfFieldController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              //// widget open hour form field
              TextFormField(
                // controller: _futsalPhoneController,
                readOnly: true,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Jam Buka',
                  hintText: 'Jam Buka',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi jam buka stadion futsal.';
                  }
                  return null;
                },
              ),
              //// widget close hour form field
              TextFormField(
                // controller: _futsalPhoneController,
                readOnly: true,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Jam Tutup',
                  hintText: 'Jam Tutup',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi jam tutup stadion futsal.';
                  }
                  return null;
                },
              ),
              15.heightBox,
              'Lapangan Flooring'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan flooring'
                  .text
                  .red500
                  .make(),
              //// widget the number of flooring fields form field
              TextFormField(
                controller: _futsalNumberOfFieldFlooringController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Jumlah Lapangan Flooring yang Tersedia',
                  hintText: 'Jumlah Lapangan Flooring yang Tersedia',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi jumlah lapangan flooring.';
                  }
                  return null;
                },
              ),
              //// widget price day of flooring fields form field
              TextFormField(
                controller: _futsalPriceDayFlooringController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Harga Sewa Pagi',
                  hintText: 'Harga Sewa Pagi',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi harga sewa pagi lapangan flooring.';
                  }
                  return null;
                },
              ),
              //// widget price night of flooring fields form field
              TextFormField(
                controller: _futsalPriceNightFlooringController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Harga Sewa Malam',
                  hintText: 'Harga Sewa Malam',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi harga sewa malam lapangan flooring.';
                  }
                  return null;
                },
              ),
              15.heightBox,
              'Lapangan Sintetis'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan sintetis'
                  .text
                  .red500
                  .make(),
              //// widget the number of synthesis fields form field
              TextFormField(
                controller: _futsalNumberOfFieldSynthesisController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Jumlah Lapangan Synthesis yang Tersedia',
                  hintText: 'Jumlah Lapangan Synthesis yang Tersedia',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi jumlah lapangan synthesis.';
                  }
                  return null;
                },
              ),
              //// widget price day of synthesis fields form field
              TextFormField(
                controller: _futsalPriceDaySynthesisController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Harga Sewa Pagi',
                  hintText: 'Harga Sewa Pagi',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi harga sewa pagi lapangan synthesis.';
                  }
                  return null;
                },
              ),
              //// widget price night of synthesis fields form field
              TextFormField(
                controller: _futsalPriceNightSynthesisController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Harga Sewa Malam',
                  hintText: 'Harga Sewa Malam',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi harga sewa malam lapangan synthesis.';
                  }
                  return null;
                },
              ),
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
              //// widget latitude location form field
              TextFormField(
                controller: _futsalLatitudeController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Latitude Lokasi',
                  hintText: 'Latitude Lokasi',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi latitude lokasi stadion futsal.';
                  }
                  return null;
                },
              ),
              //// widget longitude location form field
              TextFormField(
                controller: _futsalLongitudeController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Longitude Lokasi',
                  hintText: 'Longitude Lokasi',
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.black38,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Anda belum mengisi longitude lokasi stadion futsal.';
                  }
                  return null;
                },
              ),
              'Pratinjau Lokasi'.text.size(context.percentWidth * 5).make(),
              VxBox(
                child: 'maps'.text.makeCentered(),
              ).green300.height(context.percentWidth * 50).make(),
              20.heightBox,
              //// widget save button
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
