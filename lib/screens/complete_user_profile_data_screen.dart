import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:somedialog/somedialog.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final String _userPhoneNumber = data.userPhoneNumber();
  final String _userUID = data.userUID();
  final ImagePicker _picker = ImagePicker();
  var isLoading = true;
  var isSuccess = true;
  var image;
  var typeOperation = TypeOperation.download;

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
            (isLoading && typeOperation == TypeOperation.upload)
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.blueGrey.withOpacity(0.5),
                    child: Center(
                      child: Lottie.asset(
                        'assets/loading.json',
                        height: MediaQuery.of(context).size.height / 100 * 25,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
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
        TextButton(
          onPressed: () {
            _widgetDialogImageSource(context);
          },
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 100 * 5),
            width: MediaQuery.of(context).size.width / 100 * 40,
            height: MediaQuery.of(context).size.width / 100 * 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: (image == null)
                    ? AssetImage('assets/ben-sweet-2LowviVHZ-E-unsplash.jpg')
                    : FileImage(image),
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
          child: TextButton(
            onPressed: () {
              _widgetDialogImageSource(context);
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
            _userPhoneNumber,
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
        onPressed: () async {
          // form validation
          if (image == null) {
            return SomeDialog(
              context: context,
              path: 'assets/report.json',
              title: 'Peringatan',
              content: 'Anda belum mengambil gambar profil.',
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
            print(_fullNameController.text +
                _addressController.text +
                _emailController.text +
                image.path +
                _userPhoneNumber +
                _userUID);
            // send data to firebase
            var uploadTask = data
                .storageReference()
                .child('user-admin-profile-$_userUID')
                .child('user-admin-photo-$_userUID')
                .putFile(image);
            var streamSubscription = uploadTask.events.listen((event) async {
              var eventType = event.type;
              if (eventType == StorageTaskEventType.progress) {
                setState(() {
                  typeOperation = TypeOperation.upload;
                  isLoading = true;
                });
              } else if (eventType == StorageTaskEventType.failure) {
                _widgetSnackBar('Foto gagal diunggah');
                setState(() {
                  isLoading = false;
                  isSuccess = false;
                  typeOperation = null;
                });
              } else if (eventType == StorageTaskEventType.success) {
                try {
                  var downloadUrl = await event.snapshot.ref.getDownloadURL();

                  var userData = await data.uploadUserProfileByUserId(
                    _userUID,
                    _fullNameController.text,
                    _addressController.text,
                    _userPhoneNumber,
                    downloadUrl.toString(),
                    _emailController.text,
                  );
                  await ExtendedNavigator.root
                      .pushAndRemoveUntil(Routes.homeScreen, (route) => false);
                  setState(() {
                    isLoading = false;
                    isSuccess = true;
                    typeOperation = null;
                  });
                } catch (e) {
                  print(e);
                }
              }
            });
            await uploadTask.onComplete;
            await streamSubscription.cancel();
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

  void _widgetSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
      ),
    );
  }
}
