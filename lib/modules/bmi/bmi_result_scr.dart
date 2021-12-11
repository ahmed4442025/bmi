import 'package:flutter/material.dart';

class BMIResultScr extends StatelessWidget {
  const BMIResultScr(
      {Key? key, required this.age, required this.result, required this.isMale})
      : super(key: key);

  final int age;
  final int result;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          simpleText('txt'),
          simpleText('txt'),
          simpleText('txt'),
        ],
      ),
    );
  }

  // --------
  Widget simpleText(String txt) => Text(
        txt,
        style: const TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
      );
}
