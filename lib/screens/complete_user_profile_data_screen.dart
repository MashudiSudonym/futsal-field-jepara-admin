import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteUserProfileDataScreen extends StatefulWidget {
  @override
  _CompleteUserProfileDataScreenState createState() =>
      _CompleteUserProfileDataScreenState();
}

class _CompleteUserProfileDataScreenState
    extends State<CompleteUserProfileDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

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
            onPressed: () {},
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
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print(_fullNameController.text +
                      _addressController.text +
                      _emailController.text);
                }
              },
              child: Text('submit'),
            ),
          ],
        ),
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
