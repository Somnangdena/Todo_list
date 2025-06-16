import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + '/todo.db';
      _db = await openDatabase(
      _path,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, "
              "note TEXT, "
              "date STRING, "
              "startTime STRING, "
              "endTime STRING, "
              "color INTEGER, "
              "remind INTEGER, "
              "repeat STRING, "
              "isCompleted INTEGER)");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    try {
      return await _db!.insert(_tableName, task!.toJson());
    } catch (e) {
      print("Insert error: $e");
      print("_db is: $_db");

      return -1;
    }
  }
  


  // static Future<List<Map<String, dynamic>>> query() async {
  //   print("query funtion called");
  //   return await _db!.query(_tableName);
  // }
}
