import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksDoneScr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          List<TaskModel> tasks = cubit.allTasksDone;
          return mainContainer(cubit, tasks);
        });
  }

  mainContainer(AppCubit cubit, List<TaskModel> tasks) => Container(
        child: cubit.allTasksDone.isEmpty
            ? Center(child: tempW())
            : buildListView(cubit, tasks),
      );

  Widget tempW() => Container(
        // child: CircularProgressIndicator(),
        child: comp.simpleText(txt: 'Plz wait a sec . . .'),
      );

  Widget buildListView(AppCubit cubit, List<TaskModel> tasks) =>
      ListView.separated(
          itemBuilder: (context, i) => comp.buildTaskItem(tasks[i],
              onArchPress: () => changeToArchive(cubit, tasks[i]),
              onDisMiss: () => deleteTask(cubit, tasks[i])),
          separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey[300],
              ),
          itemCount: cubit.allTasksDone.length);

  // ====== vars =======
  Components comp = Components();

// ====== methods ======
  void changeToArchive(AppCubit cubit, TaskModel task) {
    cubit.updateStatus(id: task.id!, status: 'archived');
  }

  void deleteTask(AppCubit cubit, TaskModel task) {
    print('deleteTask TaskDone');
    cubit.deleteById(id: task.id.toString());
  }
}
