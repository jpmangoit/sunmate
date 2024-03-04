import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../localization/localization_contants.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/shared/language_select.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  String email = "";
  String password = '';
  String error = "";
  bool changeButton = false;
  String isSignIn = 'initial';
  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // dynamic result;
      // result = await Auth().signInWithEmail(email, password);
      // if (result != 200) {
      //   setState(() {
      //     isSignIn = 'initial';
      //     error = '';
      //   });
      //   return;
      // }
      // if (!mounted) return;
      // setState(() {
      //   isSignIn = 'completed';
      //   changeButton = true;
      // });
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget signupButton(themeNotifier) {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_form_sign_up'),
        style: TextStyle(
          color: getColors(themeNotifier.isDark, 'buttonTextColor'),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if (isSignIn == 'loading') {
      return const CircularProgressIndicator().centered();
    } else {
      return Icon(
        Icons.done,
        color: getColors(themeNotifier.isDark, 'buttonTextColor'),
      );
    }
  }

  Future<void> _showMyDialog(themeNotifier) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: getColors(themeNotifier.isDark, 'inputColor'),
          title: Text('Terms & Conditions',
              style: TextStyle(
                  color: getColors(themeNotifier.isDark, 'textColor'))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(
                        color: getColors(themeNotifier.isDark, 'textColor'))),
                Text(
                  'Would you like to agree?',
                  style: TextStyle(
                      color: getColors(themeNotifier.isDark, 'textColor')),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close',
                  style: TextStyle(
                      color: getColors(themeNotifier.isDark, 'textColor'))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            actions: const <Widget>[
              Padding(padding: EdgeInsets.all(5), child: LanguageSelect())
            ],
            title: Text(getTranslated(context, 'k_form_sign_up'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: getColors(themeNotifier.isDark, 'textColor'))),
          ),
          backgroundColor: getColors(themeNotifier.isDark, 'backgroundColor'),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(25),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            getTranslated(context, 'k_sign_up_create_your'),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                            ),
                          ),
                          Text(
                            getTranslated(context, 'k_sign_up_free_account'),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getTranslated(context, 'k_sign_up_sub_text'),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        getTranslated(context, 'k_form_full_name'),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_full_name');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
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
                              color: getColors(
                                  themeNotifier.isDark, 'borderColor'),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                              width: 2.0,
                            ),
                          ),
                          hintText: getTranslated(
                              context, 'k_form_full_name_placeholder'),
                          hintStyle: TextStyle(
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        getTranslated(context, 'k_form_email'),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_email');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
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
                              color: getColors(
                                  themeNotifier.isDark, 'borderColor'),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                              width: 2.0,
                            ),
                          ),
                          hintText: getTranslated(
                              context, 'k_form_email_placeholder'),
                          hintStyle: TextStyle(
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        getTranslated(context, 'k_form_zipcode'),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_zipcode');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
                          contentPadding: const EdgeInsets.all(20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'borderColor'),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                              width: 2.0,
                            ),
                          ),
                          hintText: getTranslated(
                              context, 'k_form_zipcode_placeholder'),
                          hintStyle: TextStyle(
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        getTranslated(context, 'k_form_password'),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_password');
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
                          contentPadding: const EdgeInsets.all(20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'borderColor'),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                              width: 2.0,
                            ),
                          ),
                          hintText: getTranslated(
                              context, 'k_form_password_placeholder'),
                          hintStyle: TextStyle(
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) => {
                          setState(() {
                            isSignIn = 'loading';
                          }),
                          // moveToHome(context)
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        getTranslated(context, 'k_form_language'),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      DropdownButtonFormField<String>(
                        dropdownColor:
                            getColors(themeNotifier.isDark, 'inputColor'),
                        style: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'borderColor'),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: getColors(
                                  themeNotifier.isDark, 'buttonColor'),
                              width: 2.0,
                            ),
                          ),
                          hintText: getTranslated(context, 'k_form_language'),
                          hintStyle: TextStyle(
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        onChanged: (value) {
                          setState(() {
                            // selectedLanguage = value!;
                          });
                        },
                        items:
                            <String>['Danish', 'English'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Align contents to the start vertically
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              // This is where we update the state when the checkbox is tapped
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: () => _showMyDialog(themeNotifier),
                              child: Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: getTranslated(
                                            context, 'k_sign_up_check_term'),
                                        style: TextStyle(
                                            color: getColors(
                                                themeNotifier.isDark,
                                                'GreyTextColor'),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      TextSpan(
                                          text: getTranslated(context,
                                              'k_sign_up_term_condition'),
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: getColors(
                                                  themeNotifier.isDark,
                                                  'buttonColor'),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            color: getColors(
                                                themeNotifier.isDark,
                                                'GreyTextColor'),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      TextSpan(
                                          text: getTranslated(context,
                                              'k_sign_up_private_policy'),
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: getColors(
                                                  themeNotifier.isDark,
                                                  'buttonColor'),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            color: getColors(
                                                themeNotifier.isDark,
                                                'GreyTextColor'),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      TextSpan(
                                        text: getTranslated(
                                            context, 'k_sign_up_disclaimer'),
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: getColors(
                                                themeNotifier.isDark,
                                                'buttonColor'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ])),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Material(
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
                              height: 50,
                              alignment: Alignment.center,
                              child: signupButton(themeNotifier)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated(context, 'k_sign_up_already_account'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  getColors(themeNotifier.isDark, 'textColor'),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 30),
                            ),
                            onPressed: () {
                              _formKey.currentState?.reset();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              getTranslated(context, 'k_form_login'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: getColors(
                                    themeNotifier.isDark, 'buttonColor'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
