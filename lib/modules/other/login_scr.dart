import 'package:flutter/material.dart';
import 'package:bmi_calculator/shared/components.dart';

class loginScr extends StatefulWidget {
  const loginScr({Key? key}) : super(key: key);

  @override
  _loginScrState createState() => _loginScrState();
}

class _loginScrState extends State<loginScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: manContainrt(),
    );
  }

  // ---------------------------------
  Components comp = Components();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _passwordIs = true;

  final _formKey = GlobalKey<FormState>();

  Widget manContainrt() => Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                comp.simpleTextField(controler: email),
                const SizedBox(
                  height: 20,
                ),
                comp.simpleTextField(
                    controler: password,
                    password: _passwordIs,
                    onPasswordIconPressed: changePassword,
                    passwordIcon:
                        _passwordIs ? Icons.visibility : Icons.visibility_off),
                const SizedBox(
                  height: 20,
                ),
                comp.simpleButton(onpressed: logIn),
              ],
            ),
          ),
        ),
      );

  //==========
  void logIn() {
    if (_formKey.currentState!.validate()) {
      print(password.text);
    }
  }

  void changePassword() {
    _passwordIs = !_passwordIs;
    setState(() {});
  }


}
