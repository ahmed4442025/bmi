import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          List<TaskModel> tasks = cubit.allTasksNew;
          return mainContainer(cubit, tasks);
        });
  }

  mainContainer(AppCubit cubit, List<TaskModel> tasks) => Container(
        child: cubit.allTasksNew.isEmpty
            ? Center(child: tempW())
            : buildListView(cubit, tasks),
      );

  Widget tempW() => Container(
        // child: CircularProgressIndicator(),
        child: comp.simpleText(txt: 'Plz wait a sec . . .'),
      );

  Widget buildListView(AppCubit cubit, List<TaskModel> tasks) =>
      ListView.separated(
          itemBuilder: (context, index) => comp.buildTaskItem(tasks[index],
              onDonePress: () => changeToDone(cubit, tasks[index]),
              onArchPress: () => changeToArchive(cubit, tasks[index]),
              onDisMiss: () => deleteTask(cubit, tasks[index])),
          separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey[300],
              ),
          itemCount: tasks.length);

  // ====== vars =======
  Components comp = Components();

// ====== methods ======
  void changeToArchive(AppCubit cubit, TaskModel task) {
    cubit.updateStatus(id: task.id!, status: 'archived');
  }

  void changeToDone(AppCubit cubit, TaskModel task) {
    cubit.updateStatus(id: task.id!, status: 'done');
  }

  void deleteTask(AppCubit cubit, TaskModel task) {
    print('deleteTask TaskScr');
    cubit.deleteById(id: task.id.toString());
  }
}
