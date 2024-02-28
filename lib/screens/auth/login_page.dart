import 'package:sunmate/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunmate/screens/auth/codevarificarion_page.dart';
import 'package:sunmate/screens/auth/signup_page.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/constants.dart';
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
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  loginButton() {
    if (isSignIn == 'initial') {
      return Text(
        getTranslated(context, 'k_form_login'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LanguageSelect(),
                      ],
                    ),
                    Image.asset('assets/images/logo.png'),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                     Row(
                      children: [
                        Text(
                        getTranslated(context, 'k_login_welcome'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          getTranslated(context, 'k_auth_app_name'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getTranslated(context, 'k_login_sub_text'),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.GreyTextColor),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      getTranslated(context, 'k_form_email'),
                      style: const TextStyle(
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
                          return getTranslated(context, 'k_form_require_email');
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
                        hintText: getTranslated(context, 'k_form_email_placeholder'),
                        hintStyle: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
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
                      height: 15.0,
                    ),
                    Text(
                      getTranslated(context, 'k_form_password'),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.GreyTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.buttonColor),
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
                        hintText: getTranslated(context, 'k_form_password_placeholder'),
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
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _formKey.currentState?.reset();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const CodeVerificationPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                              getTranslated(context, 'k_login_forget_password'),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.buttonColor),
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
                          print( _formKey.currentState)
                          ,
                                moveToHome(context)
                              }
                            : null,
                        child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: 400,
                            height: 50,
                            alignment: Alignment.center,
                            child: loginButton()),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getTranslated(context, 'k_login_not_have_account'),
                          style: const TextStyle(
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
                                  return const SignupPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            getTranslated(context, 'k_form_sign_up'),
                            style: const TextStyle(
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
