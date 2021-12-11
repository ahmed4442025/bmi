import 'package:sqflite/sqflite.dart';
import 'package:bmi_calculator/models/task_model.dart';

class SqlController {
  late Database database2;

  String taskTable = 'tasks';

  void createDB() async {
    var db = await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('db created');
      db
          .execute(
              'CREATE TABLE $taskTable (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });
    }, onOpen: (db) {
      print('db opened');
      database2 = db;
    });
  }

  //======

  String _taskToInserter(TaskModel task) {
    String names = 'title, date, time, status';
    String values =
        '"${task.title}", "${task.date}", "${task.time}", "${task.status}" ';
    return 'INSERT INTO $taskTable($names) VALUES($values)';
  }

  void insertNewTask(TaskModel task)  {
    database2.transaction((txn) async {
      txn.rawInsert(_taskToInserter(task)).then((value) {
        print('inserted successfully! ID: { $value }');
      }).catchError((error) {
        print('ERROR when inserting new task ${error.toString()}');
      });
    });
  }


}
