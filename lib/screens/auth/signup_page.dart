import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../localization/localization_contants.dart';
import '../../models/register.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/auth/text_form_field.dart';
import '../../widgets/shared/language_select.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  dynamic error = {};
  String selectedLanguage = "";
  bool isChecked = false;

  bool changeButton = false;
  String isSignIn = 'initial';
  final _priceFocusNode = FocusNode();

  final Map<String, String> languageCountryMap = {
    'da': 'Danish',
    'en': 'English',
  };

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      UserRegistration user = UserRegistration(
        name: nameController.text.toString(),
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
        terms: isChecked ? 1 : 0,
        lang: selectedLanguage,
        zipcode: zipCodeController.text.toString(),
      );

      dynamic result;
      result = await AuthProvider().registerUser(user);
      if (result != 201) {
        setState(() {
          isSignIn = 'initial';
          error = result['error'];
          print(error);
        });
        return;
      }
      if (!mounted) return;
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
            content: Text(getTranslated(context, 'k_form_register_success')),
            backgroundColor: Color(0xFF1AB58D),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
      await Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget signupButton(themeNotifier) {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_form_create_account'),
        style: TextStyle(
          color: getColors(themeNotifier.isDark, 'buttonTextColor'),
          fontWeight: FontWeight.w500,
          fontSize: 20,
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
                      MyTextField(
                        controller: nameController,
                        hintText: getTranslated(
                            context, 'k_form_full_name_placeholder'),
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_full_name');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (error.isNotEmpty && error.containsKey('name'))
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(
                            error['name'][0],
                            style: TextStyle(
                              color: getColors(
                                  themeNotifier.isDark, 'errorColor'), fontSize: 12.0,),
                          ),
                        ),
                      const SizedBox(
                        height: 10.0,
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
                      MyTextField(
                        controller: emailController,
                        hintText:
                            getTranslated(context, 'k_form_email_placeholder'),
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_email');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (error.isNotEmpty && error.containsKey('email'))
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(
                            error['email'][0],
                            style: TextStyle(
                              color: getColors(
                                  themeNotifier.isDark, 'errorColor'), fontSize: 12.0,),
                          ),
                        ),
                      const SizedBox(
                        height: 10.0,
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
                      MyTextField(
                        controller: zipCodeController,
                        hintText: getTranslated(
                            context, 'k_form_zipcode_placeholder'),
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_require_zipcode');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (error.isNotEmpty && error.containsKey('zipcode'))
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(
                            error['zipcode'][0],
                            style: TextStyle(
                              color: getColors(
                                  themeNotifier.isDark, 'errorColor'), fontSize: 12.0,),
                          ),
                        ),
                      const SizedBox(
                        height: 10.0,
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
                      MyTextField(
                        controller: passwordController,
                        hintText:
                            getTranslated(context, 'k_form_require_password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_password_placeholder');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (error.isNotEmpty && error.containsKey('password'))
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(
                            error['password'][0],
                            style: TextStyle(
                              color: getColors(
                                  themeNotifier.isDark, 'errorColor'), fontSize: 12.0,),
                          ),
                        ),
                      const SizedBox(
                        height: 10.0,
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
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              getColors(themeNotifier.isDark, 'inputColor'),
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                          hintText: getTranslated(context, 'k_form_language'),
                          hintStyle: TextStyle(
                            color: getColors(themeNotifier.isDark, 'textColor'),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return getTranslated(
                                context, 'k_form_select_language_required');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                          });
                        },
                        items: languageCountryMap.entries
                            .map((MapEntry<String, String> entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Align contents to the start vertically
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
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
                                  if (isChecked == false)
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(getTranslated(context,
                                            'k_form_terms_checkbox_required')),
                                        backgroundColor: Color(0xFFB00020),
                                      ))
                                    }
                                  else
                                    {
                                      setState(() {
                                        isSignIn = 'loading';
                                      }),
                                      moveToHome(context)
                                    },
                                }
                              : null,
                          child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 400,
                              height: 60,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
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
