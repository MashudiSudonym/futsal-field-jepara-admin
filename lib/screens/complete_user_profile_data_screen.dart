import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:image_picker/image_picker.dart';

enum TypeOperation {
  upload,
  download,
}

class CompleteUserProfileDataScreen extends StatefulWidget {
  @override
  _CompleteUserProfileDataScreenState createState() =>
      _CompleteUserProfileDataScreenState();
}

class _CompleteUserProfileDataScreenState
    extends State<CompleteUserProfileDataScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final String userPhoneNumber = data.userPhoneNumber();
  final String userUID = data.userUID();
  final TypeOperation _typeOperation = TypeOperation.download;
  final ImagePicker _picker = ImagePicker();
  File _image;
  bool _isLoading = true;
  bool _isSuccess = true;

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
  }

  Future<void> _getImageFromCamera() async {
    try {
      var _pickedFile = await _picker.getImage(source: ImageSource.camera);

      setState(() {
        _image = File(_pickedFile.path);
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> _getImageFromGallery() async {
    try {
      var _pickedFile = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(_pickedFile.path);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lengkapi Profil Admin'),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // image user profile
                      _widgetSelectImageProfile(context),
                      // form user profile information
                      _widgetFormProfile(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack _widgetSelectImageProfile(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FlatButton(
          onPressed: () {},
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 100 * 5),
            width: MediaQuery.of(context).size.width / 100 * 40,
            height: MediaQuery.of(context).size.width / 100 * 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage('assets/ben-sweet-2LowviVHZ-E-unsplash.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(90),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 100 * 25,
          bottom: MediaQuery.of(context).size.width / 100 * 5,
          child: FlatButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Ambil Gambar ?'),
                    content: Container(
                      child: Text('Pilih gambar dari galeri atau kamera.'),
                    ),
                    actions: [
                      Container(),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 100 * 12,
              height: MediaQuery.of(context).size.width / 100 * 12,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage('assets/camera-icon-55.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Form _widgetFormProfile(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 100 * 12,
          MediaQuery.of(context).size.width / 100 * 3,
          MediaQuery.of(context).size.width / 100 * 12,
          MediaQuery.of(context).size.width / 100 * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _widgetCommonTextFormField(
              context,
              'Anda belum mengisi nama lengkap.',
              'Nama Lengkap',
              _fullNameController,
            ),
            _widgetCommonTextFormField(
              context,
              'Anda belum mengisi alamat lengkap',
              'Alamat Lengkap',
              _addressController,
            ),
            _widgetEmailTextFormField(
                context, 'Alamat E-Mail', _emailController),
            _widgetUserPhoneNumberFormField(context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 3,
            ),
            _widgetSubmitButtonFormField(context),
          ],
        ),
      ),
    );
  }

  Container _widgetUserPhoneNumberFormField(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Telepon',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 100 * 5,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 100 * 2,
          ),
          Text(
            userPhoneNumber,
            style: TextStyle(
              letterSpacing: 3.5,
              fontSize: MediaQuery.of(context).size.width / 100 * 5,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 100 * 2,
          ),
          Text(
            '*Nomor telepon tidak dapat diganti.',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 100 * 3,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Container _widgetSubmitButtonFormField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 100 * 5.5,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print(_fullNameController.text +
                _addressController.text +
                _emailController.text);
          }
        },
        child: Text('Kirim Data'),
      ),
    );
  }

  TextFormField _widgetCommonTextFormField(
      BuildContext context,
      String errorInfo,
      String hintText,
      TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5,
        color: Colors.black87,
      ),
      decoration: _widgetInputDecorationTextFormField(context, hintText),
      validator: (value) {
        if (value.isEmpty) {
          return errorInfo;
        }
        return null;
      },
    );
  }

  TextFormField _widgetEmailTextFormField(BuildContext context, String hintText,
      TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5,
        color: Colors.black87,
      ),
      decoration: _widgetInputDecorationTextFormField(context, hintText),
      validator: (value) {
        if (!EmailValidator.validate(value)) {
          return 'Email tidak valid';
        }
        if (value.isEmpty) {
          return 'Anda belum mengisi alamat e-mail';
        }
        return null;
      },
    );
  }

  InputDecoration _widgetInputDecorationTextFormField(
      BuildContext context, String hintText) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5,
        color: Colors.black38,
      ),
    );
  }
}
