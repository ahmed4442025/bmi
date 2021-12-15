import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/layout/todo_home_layout.dart';
import 'package:bmi_calculator/modules/archived/archived_scr.dart';
import 'package:bmi_calculator/modules/tasks/tasks_scr.dart';
import 'package:bmi_calculator/modules/tasks_done/tsaks_done_scr.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  int MTBottomBarCurrentIndex = 0;
  bool MTBottomSheetShowedIs = false;
  IconData MTFABIcon = Icons.edit;

  List<TodoHomeLayoutData> screens = [
    TodoHomeLayoutData(Tasks(), 'Tasks'),
    TodoHomeLayoutData(TasksDoneScr(), 'Tasks Done'),
    TodoHomeLayoutData(ArchivedScr(), 'Archived'),
  ];

  void changeIndexBNavBar(int index){
    MTBottomBarCurrentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void chTasksListV(){
    emit(AppChTasksListV());
  }

  void chMTFABIconData(bool isOpen){
    MTBottomSheetShowedIs = !isOpen;
    MTFABIcon = isOpen ? Icons.edit : Icons.add;
    emit(AppChMTFABIcon());
  }

}