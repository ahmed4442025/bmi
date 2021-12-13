import 'package:bmi_calculator/models/task_model.dart';
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
          if (value!.isEmpty) {
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
          double borderR = 10,
          double w = double.infinity}) =>
      Container(
        width: w,
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
  simpleText({txt = 'Text', double size = 20, bool bold = false}) => Text(
        txt,
        style: TextStyle(
            fontSize: size, fontWeight: bold ? FontWeight.bold : null),
      );

  SizedBox box({double h = 20, double w = 20}) => SizedBox(
        height: h,
        width: w,
      );

  // task builder
  Widget buildTaskItem(TaskModel task) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              child: simpleText(txt: task.time, size: 15),
              radius: 35,
            ),
            box(w: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                simpleText(txt: task.title, bold: true),
                simpleText(txt: task.date),
              ],
            )
          ],
        ),
      );
}
