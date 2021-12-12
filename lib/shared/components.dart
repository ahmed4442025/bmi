import 'package:flutter/material.dart';

class Components {
  // simpleTextField
  Widget simpleTextField(
          {required TextEditingController controler,
          Function()? onPasswordIconPressed,
          Function()? ontap,
          bool password = false,
          IconData? passwordIcon,
          String lableTxt = 'text',
          TextInputType? keyBordType,
          String validatorMsg = "This field can't be empty",
          IconData? prefixIcon,
          bool readOnly = false}) =>
      TextFormField(
        controller: controler,
        onTap: ontap,
        readOnly: readOnly,
        obscureText: password,
        enableSuggestions: !password,
        autocorrect: !password,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: password ? 'password' : lableTxt,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(passwordIcon),
            onPressed: onPasswordIconPressed,
          ),
        ),
        keyboardType: password ? TextInputType.visiblePassword : keyBordType,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return validatorMsg;
          }
        },
      );

  // simple Button
  Widget simpleButton(
          {required void Function() onpressed,
          String txt = 'Log in',
          bool upercase = true,
          double hight = 40,
          Color clr = Colors.blue,
          double borderR = 10}) =>
      Container(
        width: double.infinity,
        height: 40,
        child: MaterialButton(
          onPressed: onpressed,
          child: Text(
            upercase ? txt.toUpperCase() : txt,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: clr,
        ),
      );

  // simple Text
  simpleText({txt = 'Text', double size = 20}) => Text(
        txt,
        style: TextStyle(fontSize: size),
      );

  SizedBox box({double h = 20, double w = 20}) => SizedBox(
        height: h,
        width: w,
      );
}
