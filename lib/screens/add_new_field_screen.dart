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
      TextEditingController();
  final TextEditingController _futsalLatitudeController =
      TextEditingController();
  final TextEditingController _futsalLongitudeController =
      TextEditingController();

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
          // widget form field data
          Form(
            key: _formKey,
            child: VStack([
              'Informasi Dasar'.text.xl3.make(),
              // widget name form field
              TextFormField(
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
              'Lapangan Flooring'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan flooring'
                  .text
                  .red500
                  .make(),
              'Lapangan Sintetis'.text.xl3.make(),
              'Isi dengan 0 jika tidak memiliki lapangan sintetis'
                  .text
                  .red500
                  .make(),
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
            ]).p16(),
          ),
        ]),
      ),
    );
  }

  Widget _widgetImageUpload() {
    return [
      Image(
        image: AssetImage('assets/ben-sweet-2LowviVHZ-E-unsplash.jpg'),
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
