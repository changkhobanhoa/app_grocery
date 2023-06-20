import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../api/api_service.dart';
import '../config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? fullName;
  String? password;
  String? confirmpassword;
  String? email;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: ProgressHUD(
          key: UniqueKey(),
          inAsyncCall: isAsyncCallProcess,
          opacity: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(key: globalKey, child: _registerUI(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/main.jpg",
                fit: BoxFit.contain,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Grocery App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        const Center(
          child: Text(
            "Register",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepOrangeAccent),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          "fullname",
          "Full Name",
          (onValidate) {
            if (onValidate.isEmpty) {
              return "* Required";
            }

            return null;
          },
          (onSaved) {
            fullName = onSaved.toString().trim();
          },
          showPrefixIcon: true,
          prefixIcon: const Icon(Icons.face),
          borderRadius: 10,
          contentPadding: 15,
          fontSize: 14,
          prefixIconPaddingLeft: 10,
          borderColor: Colors.grey.shade400,
          textColor: Colors.black,
          prefixIconColor: Colors.black,
          hintColor: Colors.black.withOpacity(.6),
          backgroundColor: Colors.grey.shade100,
          borderFocusColor: Colors.grey.shade200,
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          "email",
          "E-mail",
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
          borderColor: Colors.grey.shade400,
          textColor: Colors.black,
          prefixIconColor: Colors.black,
          hintColor: Colors.black.withOpacity(0.6),
          backgroundColor: Colors.grey.shade100,
          borderFocusColor: Colors.grey.shade200,
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
            context,
            "password",
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
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(0.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withOpacity(0.4),
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
            onChange: (val) {
              password = val;
            }),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          "ConfirmPassword",
          "Confir Password",
          (onValidate) {
            if (onValidate.isEmpty) {
              return "* Required";
            }

            if (onValidate != password) {
              return "Confirm Password Not Matched";
            }

            return null;
          },
          (onSaved) {
            confirmpassword = onSaved.toString().trim();
          },
          showPrefixIcon: true,
          prefixIcon: const Icon(Icons.email_outlined),
          borderRadius: 10,
          contentPadding: 15,
          fontSize: 14,
          prefixIconPaddingLeft: 10,
          borderColor: Colors.grey.shade400,
          textColor: Colors.black,
          prefixIconColor: Colors.black,
          hintColor: Colors.black.withOpacity(.6),
          backgroundColor: Colors.grey.shade100,
          borderFocusColor: Colors.grey.shade200,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hideConfirmPassword = !hideConfirmPassword;
              });
            },
            color: Colors.redAccent.withOpacity(.4),
            icon: Icon(
              hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: FormHelper.submitButton("Sign Up", () {
            if (validateSave()) {
              // Api Request
              setState(() {
                isAsyncCallProcess = true;
              });

              ApiService.registerUser(
                fullName!,
                email!,
                password!,
              ).then(
                (response) {
                  // print(response);
                  setState(() {
                    isAsyncCallProcess = false;
                  });

                  if (response) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.app_name,
                      "Registration completed SuccessFully",
                      "Ok",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.app_name,
                      "This E-mail already registered",
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
              btnColor: Colors.deepOrange,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(text: "Already have an acount?"),
                TextSpan(
                  text: "Sign In",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 14, 13, 12),
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);
                    },
                ),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
