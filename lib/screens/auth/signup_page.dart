import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../localization/localization_contants.dart';

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
      result = await Auth().signInWithEmail(email, password);
      if (result != 200) {
        setState(() {
          isSignIn = 'initial';
          error = '';
        });
        return;
      }
      if (!mounted) return;
      setState(() {
        isSignIn = 'completed';
        changeButton = true;
      });
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget signupButton() {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_form_sign_up'),
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.inputColor,
          title: const Text('Terms & Conditions',style: TextStyle(color: AppColors.textColor)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',style: TextStyle(color: AppColors.textColor)),
                Text('Would you like to agree?',style: TextStyle(color: AppColors.textColor),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close',style: TextStyle(color: AppColors.textColor)),
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.textColor, //change your color here
          ),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(getTranslated(context, 'k_form_sign_up'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textColor)),
        ),
        backgroundColor: AppColors.backgroundColor,
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
                    const Text(
                      'Create your free account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    const Text(
                      'You can always upgrade to pro plan later.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Full Name',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.buttonColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.buttonColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Enter Full Name",
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.buttonColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.buttonColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Enter Email",
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
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
                    const Text(
                      'Zip Code',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.buttonColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter zip code';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.buttonColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Enter Zip Code",
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.buttonColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.buttonColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
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
                        moveToHome(context)
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Select Language',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.inputColor,
                      style: const TextStyle(color: AppColors.buttonColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.buttonColor,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Select Language',
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      value: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                      items: <String>['Danish', 'English'].map((String value) {
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
                          child: TextButton(onPressed: _showMyDialog, child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "By Registering you agree to sunmate 10 ",
                                    style: TextStyle(
                                        color: AppColors.GreyTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        color: AppColors.GreyTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "Private Policy",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        color: AppColors.GreyTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "Disclaimer",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.bold,
                                      ),),
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
                            child: signupButton()),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                        TextButton(
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
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.buttonColor,
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
  }
}
