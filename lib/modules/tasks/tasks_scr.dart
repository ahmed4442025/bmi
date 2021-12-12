import 'package:bmi_calculator/shared/components.dart';
import 'package:bmi_calculator/shared/pupblic_vars.dart';
import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mainContainer();
  }

  mainContainer() => Container(
        child: allTasksPublic.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : buildListView(),
      );

  Widget buildListView() => ListView.separated(
      itemBuilder: (context, index) =>
          comp.buildTaskItem(allTasksPublic[index]),
      separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey[300],
          ),
      itemCount: allTasksPublic.length);

  // ====== vars =======
  Components comp = Components();

// ====== methods ======

}
