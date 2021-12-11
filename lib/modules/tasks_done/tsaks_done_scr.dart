import 'package:bmi_calculator/shared/components.dart';
import 'package:flutter/material.dart';

class TasksDoneScr extends StatelessWidget {
  TasksDoneScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mainContainer();
  }

  // ======
  final Components comp = Components();

  mainContainer() => Container(
    child: Center(
      child: comp.simpleText(txt: 'Tasks Done'),
    ),
  );
}
