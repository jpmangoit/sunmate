import 'package:sunmate/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunmate/screens/auth/codevarificarion_page.dart';
import 'package:sunmate/screens/auth/signup_page.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/colors_contant.dart';
import '../../localization/localization_contants.dart';
import '../../widgets/shared/language_select.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String email = "";
  String password = '';
  String error = "";
  bool changeButton = false;
  String isSignIn = 'initial';
  var themeCustom = "dark";

  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

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
          error = getTranslated(context, 'k_valid_email_pass');
        });
        return;
      }
      if (!mounted) return;
      setState(() {
        isSignIn = 'completed';
        changeButton = true;
      });
      // await Navigator.pushReplacementNamed(context, '/verification');
      await Navigator.pushReplacementNamed(context, '/verification');
    }
  }

  loginButton() {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_form_login'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getColors(themeCustom, 'backgroundColor'),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Image.asset('assets/images/${getLogo(themeCustom)}'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Text(
                      getTranslated(context, 'k_login_welcome'),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: getColors(themeCustom, 'textColor'),
                      ),
                    ),
                    Text(
                      getTranslated(context, 'k_auth_app_name'),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: getColors(themeCustom, 'buttonColor'),
                      ),
                    ),
                  ],
                ),
                Text(
                  getTranslated(context, 'k_login_sub_text'),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: getColors(themeCustom, 'GreyTextColor')),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  getTranslated(context, 'k_form_email'),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: getColors(themeCustom, 'GreyTextColor')),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  style: TextStyle(
                      color: getColors(themeCustom, 'textColor'), fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return getTranslated(context, 'k_form_require_email');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: getColors(themeCustom, 'inputColor'),
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
                        color: getColors(themeCustom, 'borderColor'),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: getColors(themeCustom, 'buttonColor'),
                        width: 2.0,
                      ),
                    ),
                    hintText:
                        getTranslated(context, 'k_form_email_placeholder'),
                    hintStyle: TextStyle(
                        color: getColors(themeCustom, 'textColor'),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  readOnly: isSignIn != 'initial',
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  getTranslated(context, 'k_form_password'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: getColors(themeCustom, 'GreyTextColor'),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: getColors(themeCustom, 'textColor'),
                    fontSize: 14,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return getTranslated(context, 'k_form_require_password');
                    }
                    return null;
                  },
                  readOnly: isSignIn != 'initial',
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: getColors(themeCustom, 'inputColor'),
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
                        color: getColors(themeCustom, 'borderColor'),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: getColors(themeCustom, 'buttonColor'),
                        width: 2.0,
                      ),
                    ),
                    hintText:
                        getTranslated(context, 'k_form_password_placeholder'),
                    hintStyle: TextStyle(
                        color: getColors(themeCustom, 'textColor'),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
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
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft),
                      onPressed: () {
                        _formKey.currentState?.reset();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return
                        //     },
                        //   ),
                        // );
                      },
                      child: Text(
                        getTranslated(context, 'k_login_forget_password'),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: getColors(themeCustom, 'buttonColor')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
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
                                print(_formKey.currentState),
                                moveToHome(context)
                              }
                            : null,
                        child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: 400,
                            height: 60,
                            alignment: Alignment.center,
                            child: loginButton()),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTranslated(context, 'k_login_not_have_account'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: getColors(themeCustom, 'textColor'),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        _formKey.currentState?.reset();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignupPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        getTranslated(context, 'k_form_sign_up'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: getColors(themeCustom, 'buttonColor'),
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
    );
  }
}
