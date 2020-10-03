import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futsal_field_jepara_admin/utils/router.gr.dart';
import 'package:futsal_field_jepara_admin/data/data.dart' as data;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneInputController = TextEditingController();
  final _verificationCodeInputController = TextEditingController();
  String _countryCodeInput;
  String _completePhoneNumber;
  String _message = "";
  String _verificationId;

  @override
  void dispose() {
    _phoneInputController.dispose();
    _verificationCodeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // check keyboard status for conditional layout
    bool _isKeyboardShowing = MediaQuery.of(context).viewInsets.bottom > 0;

    return _buildSignInContentLayout(context, _isKeyboardShowing);
  }

  GestureDetector _buildSignInContentLayout(
      BuildContext context, bool _isKeyboardShowing) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: _buildSignInContentBodyLayout(context, _isKeyboardShowing),
      ),
    );
  }

  ListView _buildSignInContentBodyLayout(
      BuildContext context, bool _isKeyboardShowing) {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // image logo position
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top,
                bottom: _isKeyboardShowing
                    ? MediaQuery.of(context).size.width / 100 * 25
                    : MediaQuery.of(context).size.width / 100 * 50,
              ),
            ),
            // image logo
            Center(
              child: Image(
                image: AssetImage("assets/icon.png"),
                width: MediaQuery.of(context).size.width / 100 * 50,
              ),
            ),
            // country code phone number and text field
            _buildCountryCodePhoneNumberFieldLayout(context),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 1,
            ),
            Opacity(
              opacity: (_message != "" && _message != null) ? 1 : 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 100 * 4,
                ),
                child: Text(
                  "$_message",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 3,
                    color:
                        _message != "success" ? Colors.red[400] : Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 1,
            ),
            // sign in button layout
            _buildSignInButtonLayout(context),
          ],
        ),
      ],
    );
  }

  // country code and phone number text field layout
  Padding _buildCountryCodePhoneNumberFieldLayout(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width / 100 * 15),
      child: Row(
        children: <Widget>[
          // country code
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[100],
            ),
            child: CountryCodePicker(
              onInit: (countryCode) => _countryCodeInput = countryCode.dialCode,
              initialSelection: 'ID',
              showCountryOnly: false,
              alignLeft: false,
              textStyle: TextStyle(color: Colors.black87),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 100 * 2,
          ),
          // phone number input
          Container(
            width: MediaQuery.of(context).size.width / 100 * 45,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 100 * 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextField(
              cursorColor: Colors.black87,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "", // hide word counter
                hintText: "85xxxxxx123",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black,
                ),
              ),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 100 * 5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              maxLength: 13,
              autofocus: true,
              controller: _phoneInputController,
            ),
          ),
        ],
      ),
    );
  }

  // sign in button layout
  Padding _buildSignInButtonLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 100 * 4,
      ),
      child: FlatButton(
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 100 * 5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        onPressed: () async {
          if (_phoneInputController.text != "") {
            _completePhoneNumber =
                "$_countryCodeInput${_phoneInputController.text}";

            final PhoneVerificationCompleted verificationCompleted =
                (AuthCredential phoneAuthCredential) {
              data.auth.signInWithCredential(phoneAuthCredential).then((value) {
                setState(() {
                  _message = "success";
                  ExtendedNavigator.root
                      .pushAndRemoveUntil(Routes.homeScreen, (route) => false);
                });
              }).catchError((e) {
                print(e);
              });
            };

            final PhoneVerificationFailed verificationFailed =
                (FirebaseAuthException authException) {
              setState(() {
                _message = authException.message;
              });
            };

            final PhoneCodeSent codeSent =
                (String verificationId, [int forceResendingToken]) async {
              _verificationId = verificationId;
              _dialogVerification(context);
            };

            final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
                (String verificationId) {
              _verificationId = verificationId;
            };

            await data.auth.verifyPhoneNumber(
              phoneNumber: _completePhoneNumber,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            );
          } else {
            setState(() {
              _message = "Please input phone number!!";
            });
          }
        },
      ),
    );
  }

  // dialog for input code verification
  void _dialogVerification(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Verification Code",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 100 * 5,
              color: Colors.black87,
            ),
          ),
          content: Container(
            child: TextField(
              cursorColor: Colors.black45,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Your Code",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 100 * 5,
                  color: Colors.black38,
                ),
              ),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 100 * 5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLength: 6,
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: _verificationCodeInputController,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Center(
                child: Text(
                  "Send Code",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 100 * 5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              onPressed: () async {
                final PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                  verificationId: _verificationId,
                  smsCode: _verificationCodeInputController.text,
                );

                final User user = await data.auth
                    .signInWithCredential(credential)
                    .then((value) => value.user)
                    .catchError(
                  (e) {
                    setState(() {
                      _message =
                          "Wrong Code Verification, Please resend the otp sms code.";
                    });
                    Navigator.of(context).pop();
                    _verificationCodeInputController.clear();
                  },
                );

                final currentUser = data.auth.currentUser;

                assert(user.uid == currentUser.uid);

                setState(() {
                  if (user != null) {
                    _message = "success";
                    ExtendedNavigator.root.pushAndRemoveUntil(
                        Routes.homeScreen, (route) => false);
                  } else {
                    _message = "Sign in failed";
                    _verificationCodeInputController.clear();
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
