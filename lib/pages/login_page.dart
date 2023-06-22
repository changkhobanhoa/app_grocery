import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../api/api_service.dart';
import '../config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? email;
  String? password;
  bool hidePassword = true;
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isAsyncCallProcess,
          opacity: .3,
          key: UniqueKey(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: globalKey,
                child: _loginUI(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Image.asset(
              "assets/main.jpg",
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Grocery App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "Email",
            "E-Mail",
            (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }

              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(onValidate);

              if (!emailValid) {
                return "Invalid E-Mail";
              }

              return null;
            },
            (onSaved) {
              email = onSaved.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade200,
            prefixIconColor: Colors.black,
            hintFontSize: 14,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "Password",
            "Password",
            (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }

              return null;
            },
            (onSaved) {
              password = onSaved.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.lock_open),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade200,
            prefixIconColor: Colors.black,
            hintFontSize: 14,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 10),
          Center(
            child: FormHelper.submitButton(
              "Sign In",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAsyncCallProcess = true;
                  });
                  ApiService.login(email!, password!).then(
                    (res) {
                      setState(() {
                        isAsyncCallProcess = false;
                      });
                      if (res) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "User Logged-In Successfully",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Invalid Email/Password",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: Colors.deepOrangeAccent,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 20,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Dont have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: " Sign Up",
                    style: const TextStyle(
                      color: Colors.deepOrangeAccent,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/registore", (route) => false);
                      },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
