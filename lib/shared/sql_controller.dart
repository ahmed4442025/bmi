import 'package:bmi_calculator/shared/pupblic_vars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bmi_calculator/models/task_model.dart';

class SqlController {
  late Database database2;
  final String _taskTable = 'tasks';
  late List<Map> allTasks;

  void createDB() async {
    await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('db created');
      db
          .execute(
              'CREATE TABLE $_taskTable (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });
    }, onOpen: (db) {
      print('db opened');
      setAllTasksToVar(db);
      database2 = db;

    });
  }

  //======

  String _taskToInserter(TaskModel task) {
    String names = 'title, date, time, status';
    String values =
        '"${task.title}", "${task.date}", "${task.time}", "${task.status}" ';
    return 'INSERT INTO $_taskTable($names) VALUES($values)';
  }

  void insertNewTask(TaskModel task) {
    database2.transaction((txn) async {
      txn.rawInsert(_taskToInserter(task)).then((value) {
        print('inserted successfully! ID: { $value }');
      }).catchError((error) {
        print('ERROR when inserting new task ${error.toString()}');
      });
    });
    setAllTasksToVar(database2);
  }

  Future<List<Map>> _getAllTasksFromTabl(Database db) async{
    return await db.rawQuery('SELECT * FROM $_taskTable');
  }

  setAllTasksToVar(Database db){
    _getAllTasksFromTabl(db).then((value){
      allTasks = value;
      _tasksRawToTaksModel(value);
    });
  }

  _tasksRawToTaksModel(List<Map<dynamic, dynamic>> tasksRaw){
    for(int i =0; i<tasksRaw.length; i++){
      allTasksPublic.add(TaskModel.fromMap(tasksRaw[i]));
    }
  }


}
