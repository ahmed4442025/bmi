import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/modules/archived/archived_scr.dart';
import 'package:bmi_calculator/modules/tasks/tasks_scr.dart';
import 'package:bmi_calculator/modules/tasks_done/tsaks_done_scr.dart';
import 'package:bmi_calculator/shared/sql_controller.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:flutter/rendering.dart';

class TodoHomeLayout extends StatefulWidget {
  const TodoHomeLayout({Key? key}) : super(key: key);

  @override
  _TodoHomeLayoutState createState() => _TodoHomeLayoutState();
}

class _TodoHomeLayoutState extends State<TodoHomeLayout> {
  @override
  void initState() {
    super.initState();
    sqlC.createDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(),
      floatingActionButton: floatingB(),
      body: screens[bottomBarCurrentIndex].scr,
      bottomNavigationBar: bottomBar(),
    );
  }

  // ===============

  // ----------- VARS -----------
  Components comp = Components();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool bottomSheetShowedIs = false;
  IconData fabIcon = Icons.edit;
  int bottomBarCurrentIndex = 0;
  TextEditingController titleContrl = TextEditingController();
  TextEditingController timeContrl = TextEditingController();
  TextEditingController statusContrl = TextEditingController();
  TextEditingController dateContrl = TextEditingController();
  SqlController sqlC = SqlController();
  List<TodoHomeLayoutData> screens = [
    TodoHomeLayoutData(Tasks(), 'Tasks'),
    TodoHomeLayoutData(TasksDoneScr(), 'Tasks Done'),
    TodoHomeLayoutData(ArchivedScr(), 'Archived'),
  ];

  // ========= Widgets ==========

  //app Bar
  appBar() => AppBar(
          title: Center(
        child: Text(screens[bottomBarCurrentIndex].title),
      ));

  // main Floating Button
  floatingB() => FloatingActionButton(
      onPressed: () {
        if (bottomSheetShowedIs) {
          if (formKey.currentState!.validate()) {
            sqlC.insertNewTask(getInfoAsTask());
            showBottomSheet();
          }
        } else {
          showBottomSheet();
        }
      },
      child: Icon(fabIcon));

  // main Container
  mainContainer() => Container();

  // bottom bar
  BottomNavigationBar bottomBar() => BottomNavigationBar(
          currentIndex: bottomBarCurrentIndex,
          onTap: (index) {
            setState(() {
              bottomBarCurrentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.format_align_justify), label: 'Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Archived'),
          ]);

  // build bottom sheet with 3 texts
  Widget bottomSheet1() => Container(
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
                  ontap: setTimeCFromPicker),
              comp.box(),
              comp.simpleTextField(
                  controler: dateContrl,
                  lableTxt: 'date',
                  prefixIcon: Icons.calendar_today,
                  readOnly: true,
                  ontap: setDateCFromPicker),
              comp.box(),
            ],
          ),
        ),
      );

  // ======= Methods =======

  // change is open status and FAB icon
  void changeFABData(bool isOpen) {
    bottomSheetShowedIs = !isOpen;
    fabIcon = isOpen ? Icons.edit : Icons.add;
    setState(() {});
  }

  // show bottom sheet
  void showBottomSheet() {
    if (bottomSheetShowedIs) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      changeFABData(bottomSheetShowedIs);
    } else {
      scaffoldKey.currentState!
          .showBottomSheet((context) => bottomSheet1())
          .closed
          .then((value) {
        changeFABData(true);
      });
      changeFABData(bottomSheetShowedIs);
    }
  }

  //show Time picker
  void setTimeCFromPicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      timeContrl.text = value!.format(context);
    });
  }

  // show date picker
  void setDateCFromPicker() {
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
