import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../localization/localization_contants.dart';
import '../../widgets/shared/language_select.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({Key? key}) : super(key: key);

  @override
  CodeVerificationPageState createState() => CodeVerificationPageState();
}

class CodeVerificationPageState extends State<CodeVerificationPage> {
  String error = "";
  bool changeButton = false;
  String isSignIn = 'initial';
  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String selectedLanguage = 'English';
  bool isChecked = false;
  var themeCustom = true;

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      dynamic result;
      // result = await Auth().signInWithEmail(email, password);
      // if (result != 200) {
      //   setState(() {
      //     isSignIn = 'initial';
      //     error = 'please enter a valid email and password';
      //   });
      //   return;
      // }
      if (!mounted) return;
      setState(() {
        isSignIn = 'completed';
        changeButton = true;
      });
      await Navigator.pushReplacementNamed(context, '/firstHome');
    }
  }

  Widget verifyButton() {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_verify_button'),
        style: TextStyle(
          color: getColors(themeCustom, 'buttonTextColor'),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (isSignIn == 'loading') {
      return const CircularProgressIndicator().centered();
    } else {
      return Icon(
        Icons.done,
        color: getColors(themeCustom, 'buttonTextColor'),
      );
    }
  }

  Widget _textFieldOTP({bool? first, last}) {
    return Container(
      height: 65,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: getColors(themeCustom, 'buttonColor')),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            contentPadding: const EdgeInsets.only(bottom: 50, top: 50),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: getColors(themeCustom, 'borderColor'),
                ),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: getColors(themeCustom, 'buttonColor')),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColors(themeCustom, 'textColor'), //change your color here
          ),
          backgroundColor: getColors(themeCustom, 'backgroundColor'),
          centerTitle: true,
          title: Text(
            getTranslated(context, 'k_verify'),
            textAlign: TextAlign.center,
            style: TextStyle(color: getColors(themeCustom, 'textColor')),
          ),
          actions: const <Widget>[
            Padding(padding: EdgeInsets.all(5), child: LanguageSelect())
          ],
        ),
        backgroundColor: getColors(themeCustom, 'backgroundColor'),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      getTranslated(context, 'k_verify_heading'),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: getColors(themeCustom, 'textColor'),
                      ),
                    ),
                    Text(
                      getTranslated(context, 'k_verify_digits_code'),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: getColors(themeCustom, 'buttonColor'),
                      ),
                    ),
                  ],
                ),
                Text(
                  getTranslated(context, 'k_verify_sub_text'),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: getColors(themeCustom, 'GreyTextColor')),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textFieldOTP(first: true, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: true),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTranslated(context, 'k_verify_resend'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColors(themeCustom, 'textColor'),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      getTranslated(context, 'k_verify_resend_code'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: getColors(themeCustom, 'buttonColor'),
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Material(
                      color: getColors(themeCustom, 'buttonColor'),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => _formKey.currentState!.validate()
                            ? {
                                setState(() {
                                  isSignIn = 'loading';
                                }),
                                moveToHome(context)
                              }
                            : null,
                        child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: 400,
                            height: 60,
                            alignment: Alignment.center,
                            child: verifyButton()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
