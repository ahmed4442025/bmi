import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:bmi_calculator/shared/sql_controller.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..openDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          return myScaffold(context, cubit);
        }
      ),
    );
  }

  // ===============

  // ----------- VARS -----------
  Components comp = Components();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titleContrl = TextEditingController();
  TextEditingController timeContrl = TextEditingController();
  TextEditingController statusContrl = TextEditingController();
  TextEditingController dateContrl = TextEditingController();

  // ========= Widgets ==========

  Scaffold myScaffold(BuildContext context, cubit) => Scaffold(
        key: scaffoldKey,
        appBar: appBar(cubit),
        floatingActionButton: floatingB(context, cubit),
        body: cubit.screens[cubit.MTBottomBarCurrentIndex].scr,
        bottomNavigationBar: bottomBar(cubit),
      );

  //app Bar
  appBar(cubit) => AppBar(
          title: Center(
            child: Text(cubit.screens[cubit.MTBottomBarCurrentIndex].title),
      ));

  // main Floating Button
  floatingB(BuildContext context,AppCubit cubit) => FloatingActionButton(
      onPressed: () {
        if (cubit.MTBottomSheetShowedIs) {
          if (formKey.currentState!.validate()) {
            cubit.insertTask(getInfoAsTask());
            showBottomSheet(context, cubit);
          }
        } else {
          showBottomSheet(context, cubit);
        }
      },
      child: Icon(cubit.MTFABIcon));

  // main Container
  mainContainer() => Container();

  // bottom bar
  BottomNavigationBar bottomBar(AppCubit cubit) => BottomNavigationBar(
          currentIndex: cubit.MTBottomBarCurrentIndex,
          onTap: (index) {
                cubit.changeIndexBNavBar(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.format_align_justify), label: 'Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Archived'),
          ]);

  // build bottom sheet with 3 texts
  Widget bottomSheet1(BuildContext context) => Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              comp.simpleTextField(
                  controler: titleContrl,
                  lableTxt: 'title',
                  prefixIcon: Icons.title),
              comp.box(),
              comp.simpleTextField(
                  controler: timeContrl,
                  lableTxt: 'time',
                  prefixIcon: Icons.watch_later_outlined,
                  readOnly: true,
                  ontap: () => setTimeCFromPicker(context)),
              comp.box(),
              comp.simpleTextField(
                  controler: dateContrl,
                  lableTxt: 'date',
                  prefixIcon: Icons.calendar_today,
                  readOnly: true,
                  ontap: () => setDateCFromPicker(context)),
              comp.box(),
            ],
          ),
        ),
      );

  // ======= Methods =======

  // change is open status and FAB icon
  void changeFABData(bool isOpen, cubit) {
    cubit
        .chMTFABIconData(cubit.MTBottomSheetShowedIs);
  }

  // show bottom sheet
  void showBottomSheet(BuildContext context, cubit) {
    if (cubit.MTBottomSheetShowedIs) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      changeFABData(cubit.MTBottomSheetShowedIs, cubit);
    } else {
      scaffoldKey.currentState!
          .showBottomSheet((context) => bottomSheet1(context))
          .closed
          .then((value) {
        changeFABData(cubit.MTBottomSheetShowedIs, cubit);
      });
      changeFABData(cubit.MTBottomSheetShowedIs, cubit);
    }
  }

  //show Time picker
  void setTimeCFromPicker(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      timeContrl.text = value!.format(context);
    });
  }

  // show date picker
  void setDateCFromPicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020, 1),
            lastDate: DateTime(2030, 1))
        .then((value) {
      if (value != null) {
        dateContrl.text = value.toString().split(' ')[0];
      }
    });
  }

  // get info as a Task
  getInfoAsTask() =>
      TaskModel(titleContrl.text, dateContrl.text, timeContrl.text, 'new');
}

class TodoHomeLayoutData {
  Widget? scr;
  String title = "todo app";

  TodoHomeLayoutData(this.scr, this.title);
}
