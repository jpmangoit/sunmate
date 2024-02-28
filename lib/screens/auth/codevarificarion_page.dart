import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget verifyButton() {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_verify'),
        style: const TextStyle(
          color: AppColors.buttonTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (isSignIn == 'loading') {
      return const CircularProgressIndicator().centered();
    } else {
      return const Icon(
        Icons.done,
        color: AppColors.buttonTextColor,
      );
    }
  }

  Widget _textFieldOTP({bool? first, last}) {
    return Container(
      height: 80,
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.buttonColor),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.textColor),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: AppColors.buttonColor),
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
          iconTheme: const IconThemeData(
            color: AppColors.textColor, //change your color here
          ),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
              getTranslated(context, 'k_verify'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textColor),
          ),
          actions: const <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: LanguageSelect()
            )
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'k_verify_heading'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    getTranslated(context, 'k_verify_sub_text'),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.GreyTextColor),
                  ),
                  const SizedBox(
                    height: 20.0,
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
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated(context, 'k_verify_resend_code'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonColor,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    color: AppColors.buttonColor,
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
                          height: 50,
                          alignment: Alignment.center,
                          child: verifyButton()),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
