import 'package:sqflite/sqflite.dart';
import 'package:bmi_calculator/models/task_model.dart';

class SqlController {
  late Database database2;
  final String _taskTable = 'tasks';
  late List<Map> allTasks;

  Future<Database> createDB() async {
    String cT =
        'CREATE TABLE $_taskTable (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)';
    await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('db created');
      db.execute(cT).then((value) {
        print('table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });
    }, onOpen: (db) {
      print('db opened');
      database2 = db;
    });
    return database2;
  }

  //======

  String _taskToInserter(TaskModel task) {
    String names = 'title, date, time, status';
    String values =
        '"${task.title}", "${task.date}", "${task.time}", "${task.status}" ';
    return 'INSERT INTO $_taskTable($names) VALUES($values)';
  }

  void insertNewTask(TaskModel task) async {
    await database2.transaction((txn) async {
      txn.rawInsert(_taskToInserter(task)).then((value) {
        print('inserted successfully! ID: { $value }');
      }).catchError((error) {
        print('ERROR when inserting new task ${error.toString()}');
      });
    });
  }

  Future<List<Map>> _getAllTasksFromTabl(Database db) async {
    return await db.rawQuery('SELECT * FROM $_taskTable');
  }

  Future<List<TaskModel>> setAllTasksToVar11111(Database db) async {
    _getAllTasksFromTabl(db).then((value) {
      allTasks = value;
      print(_tasksRawToTaksModel(value));
      return _tasksRawToTaksModel(value);
    });
    return [];
  }

  Future<List<TaskModel>> setAllTasksToVar(Database db) async {
    var value = await _getAllTasksFromTabl(db);
    allTasks = value;
    return _tasksRawToTaksModel(value);
  }

  List<TaskModel> _tasksRawToTaksModel(List<Map<dynamic, dynamic>> tasksRaw) {
    List<TaskModel> lis = [];
    for (int i = 0; i < tasksRaw.length; i++) {
      lis.add(TaskModel.fromMap(tasksRaw[i]));
    }
    return lis;
  }

  Future<int> updateStatus(Database db,
      {required int id, required String status}) async {
    int count = await db.rawUpdate(
        'UPDATE $_taskTable SET status = ? WHERE id = ?', [status, id]);
    return count;
  }

  Future<int> deletebyId(Database db, {required String id}) async {
    int count = await db.rawDelete('DELETE FROM $_taskTable WHERE id = ?', [id]);
    return count;
  }
}
