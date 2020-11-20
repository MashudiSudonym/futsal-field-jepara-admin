import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:somedialog/somedialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

enum TypeOperation {
  upload,
  download,
}

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
      TextEditingController(text: '-6.633331');
  final TextEditingController _futsalLongitudeController =
      TextEditingController(text: '110.7173391');
  final String _userPhoneNumber = data.userPhoneNumber();
  final String _userUID = data.userUID();
  final ImagePicker _picker = ImagePicker();
  var isLoading = true;
  var isSuccess = true;
  var image;
  var typeOperation = TypeOperation.download;
  TextEditingController _openTimePickerController = TextEditingController();
  TextEditingController _closeTimePickerController = TextEditingController();
  String _openTimeValue = '';
  String _closeTimeValue = '';
  TimeOfDay _startTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectOpenTime(BuildContext context) async {
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
        _openTimeValue = _startTime.format(context);
        _openTimePickerController =
            TextEditingController(text: _openTimeValue.replaceAll(':', '.'));
      });
    }
  }

  Future<void> _selectCloseTime(BuildContext context) async {
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
        _closeTimeValue = _startTime.format(context);
        _closeTimePickerController =
            TextEditingController(text: _closeTimeValue.replaceAll(':', '.'));
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    try {
      var _pickedFile = await _picker.getImage(source: ImageSource.camera);

      setState(() {
        image = File(_pickedFile.path);
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> _getImageFromGallery() async {
    try {
      var _pickedFile = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        image = File(_pickedFile.path);
      });
    } catch (err) {
      print(err);
    }
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
        body: ZStack([
          (isLoading && typeOperation == TypeOperation.upload)
              ? VxBox(
                  child: Lottie.asset(
                    'assets/loading.json',
                    height: context.percentHeight * 25,
                  ),
                )
                  .color(Vx.blue100.withOpacity(0.5))
                  .size(double.infinity, double.infinity)
              : VStack([
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
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Jumlah Total Lapangan',
                          hintText: 'Jumlah Total Lapangan',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        controller: _openTimePickerController,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        onTap: () {
                          setState(() {
                            _selectOpenTime(context);
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Jam Buka',
                          hintText: '$_openTimeValue',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        controller: _closeTimePickerController,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        onTap: () {
                          setState(() {
                            _selectCloseTime(context);
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Jam Tutup',
                          hintText: '$_closeTimeValue',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Jumlah Lapangan Flooring yang Tersedia',
                          hintText: 'Jumlah Lapangan Flooring yang Tersedia',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Harga Sewa Pagi',
                          hintText: 'Harga Sewa Pagi',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Harga Sewa Malam',
                          hintText: 'Harga Sewa Malam',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Jumlah Lapangan Synthesis yang Tersedia',
                          hintText: 'Jumlah Lapangan Synthesis yang Tersedia',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Harga Sewa Pagi',
                          hintText: 'Harga Sewa Pagi',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 100 * 5,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Harga Sewa Malam',
                          hintText: 'Harga Sewa Malam',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
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
                      20.heightBox,
                      //// widget save button
                      ElevatedButton.icon(
                        label: 'Simpan'.text.make(),
                        icon: FaIcon(FontAwesomeIcons.save),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(context.percentWidth * 2),
                        ),
                        onPressed: () async {
                          //// form validation
                          if (image == null) {
                            return SomeDialog(
                              context: context,
                              path: 'assets/report.json',
                              title: 'Peringatan',
                              content:
                                  'Anda belum mengambil foto stadion futsal.',
                              submit: () {},
                              mode: SomeMode.Lottie,
                              appName: 'Futsal Field Jepara',
                              buttonConfig: ButtonConfig(
                                buttonDoneColor: Colors.blue,
                                dialogDone: 'Oke',
                                dialogCancel: '',
                                buttonCancelColor: Hexcolor('#FFFFFF'),
                              ),
                            );
                          }
                          if (_formKey.currentState.validate()) {
                            context.showToast(
                                msg:
                                    '${_futsalLongitudeController.text} ${_futsalLatitudeController.text} ${_openTimePickerController.text} ${_closeTimePickerController.text}');
                          }
                        },
                      ).box.width(double.infinity).make(),
                      20.heightBox,
                    ],).p16(),
                  ),
                ],).scrollVertical(),
        ]),
      ),
    );
  }

  Widget _widgetImageUpload() {
    return [
      Image(
        image: (image != null)
            ? FileImage(image)
            : AssetImage('assets/icon-admin.jpeg'),
      ),
      ElevatedButton.icon(
        onPressed: () {
          _widgetDialogImageSource(context);
        },
        style: ElevatedButton.styleFrom(),
        icon: FaIcon(FontAwesomeIcons.camera),
        label: 'Foto Lapangan'.text.make(),
      )
    ].vStack().box.width(double.infinity).make();
  }

  Future _widgetDialogImageSource(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ambil Gambar ?'),
          content: Container(
            child: Text('Pilih gambar dari galeri atau kamera.'),
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 100 * 3,
              ),
              child: TextButton(
                onPressed: () {
                  _getImageFromCamera();
                  ExtendedNavigator.root.pop();
                },
                child: Text(
                  'Kamera',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 100 * 3,
              ),
              child: TextButton(
                onPressed: () {
                  _getImageFromGallery();
                  ExtendedNavigator.root.pop();
                },
                child: Text(
                  'Galeri',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
