import 'package:bmi_calculator/models/task_model.dart';
import 'package:bmi_calculator/modules/archived/archived_scr.dart';
import 'package:bmi_calculator/modules/tasks/tasks_scr.dart';
import 'package:bmi_calculator/modules/tasks_done/tsaks_done_scr.dart';
import 'package:bmi_calculator/shared/sql_controller.dart';
import 'package:flutter/material.dart';

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
      appBar: appBar(),
      floatingActionButton: floatingB(),
      body: screens[bottomBarCurrentIndex].scr,
      bottomNavigationBar: bottomBar(),
    );
  }

  // ===============
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

  int bottomBarCurrentIndex = 0;
  SqlController sqlC = SqlController();
  List<TodoHomeLayoutData> screens = [
    TodoHomeLayoutData(Tasks(), 'Tasks'),
    TodoHomeLayoutData(TasksDoneScr(), 'Tasks Done'),
    TodoHomeLayoutData(ArchivedScr(), 'Archived'),
  ];

  //app Bar
  appBar() => AppBar(
          title: Center(
        child: Text(screens[bottomBarCurrentIndex].title),
      ));

  // main Floating Button
  floatingB() => FloatingActionButton(
      onPressed: () {
        // sqlC.insertNewTask(new TaskModel('title', 'date', 'time', 'status'));
        showTimePicker(context: context, initialTime : TimeOfDay.now());
      },
      child: Icon(Icons.add));

  // main Container
  mainContainer() => Container();

  // ============
  addNewTask() async {
    sqlC.createDB();
  }
}

class TodoHomeLayoutData {
  Widget? scr;
  String title = "todo app";

  TodoHomeLayoutData(this.scr, this.title);
}
