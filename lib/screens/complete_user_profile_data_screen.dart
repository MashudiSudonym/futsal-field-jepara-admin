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
          title: Text('Complete your profile data'),
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
                      _buildImageProfile(context),
                      // form user profile information
                      _buildFormProfile(context),
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

  Stack _buildImageProfile(BuildContext context) {
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
                image: AssetImage("assets/ben-sweet-2LowviVHZ-E-unsplash.jpg"),
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
      ],
    );
  }

  Form _buildFormProfile(BuildContext context) {
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
            commonTextFormField(
              context,
              'Anda belum mengisi nama lengkap.',
              'Nama Lengkap',
              _fullNameController,
            ),
            commonTextFormField(
              context,
              'Anda belum mengisi alamat lengkap',
              'Alamat Lengkap',
              _addressController,
            ),
            emailTextFormField(context, 'Alamat E-Mail', _emailController),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print(_fullNameController.text + _addressController.text + _emailController.text);
                }
              },
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField commonTextFormField(BuildContext context, String errorInfo,
      String hintText, TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5,
        color: Colors.black87,
      ),
      decoration: inputDecorationTextFormField(context, hintText),
      validator: (value) {
        if (value.isEmpty) {
          return errorInfo;
        }
        return null;
      },
    );
  }

  TextFormField emailTextFormField(BuildContext context,
      String hintText, TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5,
        color: Colors.black87,
      ),
      decoration: inputDecorationTextFormField(context, hintText),
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

  InputDecoration inputDecorationTextFormField(
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
