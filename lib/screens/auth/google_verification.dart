import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../localization/localization_contants.dart';
import '../../providers/google_verify_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/shared/language_select.dart';

class GoogleVerificationPage extends StatefulWidget {
  const GoogleVerificationPage({Key? key}) : super(key: key);

  @override
  GoogleVerificationPageState createState() => GoogleVerificationPageState();
}

class GoogleVerificationPageState extends State<GoogleVerificationPage> {
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
    final pref = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      dynamic result;
      print(code);
      result = Provider.of<GoogleVerificationProvider>(context, listen: false)
          .googleVerification(code, context);
      // await pref.setString('token', result['token']);
      // if (!mounted) return;
      if (result['success'] == true) {
        setState(() {
          isSignIn = 'completed';
          changeButton = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.up,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  left: 10,
                  right: 10),
              content: Text(getTranslated(context, 'k_form_login_success')),
              backgroundColor: Color(0xFF1AB58D),
              behavior: SnackBarBehavior.floating,
            ),
          );
        });
        await Navigator.pushReplacementNamed(context, '/firstHome');
      }
    }
  }

  Widget verifyButton(themeNotifier) {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_verify_button'),
        style: TextStyle(
          color: getColors(themeNotifier.isDark, 'buttonTextColor'),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (isSignIn == 'loading') {
      return CircularProgressIndicator(
        color: getColors(themeNotifier.isDark, 'buttonTextColor'),
      ).centered();
    } else {
      return Icon(
        Icons.done,
        color: getColors(themeNotifier.isDark, 'buttonTextColor'),
      );
    }
  }

  var code;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: getColors(
                  themeNotifier.isDark, 'textColor'), //change your color here
            ),
            backgroundColor: getColors(themeNotifier.isDark, 'backgroundColor'),
            centerTitle: true,
            title: Text(
              getTranslated(context, 'k_verify'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: getColors(themeNotifier.isDark, 'textColor')),
            ),
            actions: const <Widget>[
              Padding(padding: EdgeInsets.all(5), child: LanguageSelect())
            ],
          ),
          backgroundColor: getColors(themeNotifier.isDark, 'backgroundColor'),
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
                          color: getColors(themeNotifier.isDark, 'textColor'),
                        ),
                      ),
                      Text(
                        getTranslated(context, 'k_verify_google_code'),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: getColors(themeNotifier.isDark, 'buttonColor'),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 20),

                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: getColors(themeNotifier.isDark, 'textColor'),
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: getColors(themeNotifier.isDark, 'inputColor'),
                      contentPadding: const EdgeInsets.all(20),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: getColors(themeNotifier.isDark, 'borderColor'),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: getColors(themeNotifier.isDark, 'buttonColor'),
                          width: 2.0,
                        ),
                      ),
                      hintText: getTranslated(context, 'k_form_code'),
                      hintStyle: TextStyle(
                          color: getColors(themeNotifier.isDark, 'textColor'),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      code = value;
                      setState(() {});
                    },
                  ),

                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Material(
                        color: getColors(themeNotifier.isDark, 'buttonColor'),
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
                              child: verifyButton(themeNotifier)),
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
    });
  }
}
