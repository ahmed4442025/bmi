import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedScr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          List<TaskModel> tasks = cubit.allTasksArchived;
          return mainContainer(cubit, tasks);
        });
  }

  mainContainer(AppCubit cubit, List<TaskModel> tasks) => Container(
        child: tasks.isEmpty
            ? Center(child: tempW())
            : buildListView(cubit, tasks),
      );

  Widget tempW() => Container(
        // child: CircularProgressIndicator(),
        child: comp.simpleText(txt: 'no tasks here '),
      );

  Widget buildListView(AppCubit cubit, List<TaskModel> tasks) =>
      ListView.separated(
          itemBuilder: (context, index) => comp.buildTaskItem(
                tasks[index],
                onDonePress: () => changeToDone(cubit, tasks[index]),
                onDisMiss: () => deleteTask(cubit, tasks[index]),
              ),
          separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey[300],
              ),
          itemCount: tasks.length);

  // ====== vars =======
  Components comp = Components();

// ====== methods ======
  void changeToDone(AppCubit cubit, TaskModel task) {
    cubit.updateStatus(id: task.id!, status: 'done');
  }

  void deleteTask(AppCubit cubit, TaskModel task) {
    cubit.deleteById(id: task.id.toString());
  }
}
