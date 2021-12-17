import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/layout/todo_home_layout.dart';
import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/modules/archived/archived_scr.dart';
import 'package:bmi_calculator/modules/tasks/tasks_scr.dart';
import 'package:bmi_calculator/modules/tasks_done/tsaks_done_scr.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:bmi_calculator/shared/sql_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // shared vars
  List<TaskModel> allTasksNew = [];
  List<TaskModel> allTasksDone = [];
  List<TaskModel> allTasksArchived = [];

  // ======== MAIN_TODO ========
  // vars
  int MTBottomBarCurrentIndex = 0;
  bool MTBottomSheetShowedIs = false;
  IconData MTFABIcon = Icons.edit;

  // list of screens and titles for HomeTodo
  List<TodoHomeLayoutData> screens = [
    TodoHomeLayoutData(Tasks(), 'Tasks'),
    TodoHomeLayoutData(TasksDoneScr(), 'Tasks Done'),
    TodoHomeLayoutData(ArchivedScr(), 'Archived'),
  ];

  // when pressing Bottom nav bar
  void changeIndexBNavBar(int index) {
    MTBottomBarCurrentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  // change FABottom Icon
  void chMTFABIconData(bool isOpen) {
    MTBottomSheetShowedIs = !isOpen;
    MTFABIcon = isOpen ? Icons.edit : Icons.add;
    emit(AppChMTFABIcon());
  }

  // ======== tasks_scr ========

  // rebuild ListView of tasks
  void chTasksListV() {
    emit(AppChTasksListV());
  }

  // ======== SQL ========
  SqlController sql = SqlController();
  late Database db;

  // open or create DB
  void openDB() {
    sql.createDB().then((value) {
      db = value;
      sql.setAllTasksToVar(db).then((value) {
        _setAllTasksVars(value);
        emit(AppGetTasksFDB());
      });
    });
  }

  // insert new Task
  void insertTask(TaskModel task) {
    sql.insertNewTask(task);
    sql.setAllTasksToVar(db).then((value) {
      _setAllTasksVars(value);
      emit(AppGetTasksFDB());
    });
  }

  // update status
  void updateStatus({required int id, required String status}) {
    sql.updateStatus(db, id: id, status: status).then((value) {
      emit(AppUpdateDB());
      sql.setAllTasksToVar(db).then((value) {
        _setAllTasksVars(value);
        emit(AppGetTasksFDB());
      });
    });
  }

  // delete element
  void deleteById({required String id}) {
    sql.deletebyId(db, id: id).then((value) {
      emit(AppDeleteFromDB());
      sql.setAllTasksToVar(db).then((value) {
        _setAllTasksVars(value);
        emit(AppGetTasksFDB());
      });
    });
  }

  void _setAllTasksVars(List<TaskModel> tasks) {
    allTasksNew = [];
    allTasksDone = [];
    allTasksArchived = [];

    tasks.forEach((element) {
      if (element.status == 'new') {
        allTasksNew.add(element);
      }
      if (element.status == 'done') {
        allTasksDone.add(element);
      }
      if (element.status == 'archived') {
        allTasksArchived.add(element);
      }
    });
    screens[0].title =
        "Tasks" + (allTasksNew.isEmpty ? "" : " (${allTasksNew.length})");
    screens[1].title = "Tasks Done" +
        (allTasksDone.isEmpty ? "" : " (${allTasksDone.length})");
    screens[2].title = "Archived" +
        (allTasksArchived.isEmpty ? "" : " (${allTasksArchived.length})");


    // emit(AppChTasksListV());
  }
}
