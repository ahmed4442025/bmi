import 'package:bmi_calculator/shared/components.dart';
import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mainContainer();
  }

  // ======
  Components comp = Components();

  mainContainer() => Container(
        child: Center(
          child: comp.simpleText(txt: 'Tasks'),
        ),
      );
}
