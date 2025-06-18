import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title TEXT, 
              note TEXT, 
              date STRING, 
              startTime STRING, 
              endTime STRING, 
              color INTEGER, 
              remind INTEGER, 
              repeat STRING, 
              isCompleted INTEGER)
    ''');
  }

  static Future<int> insert(Task? task) async {
    final Database dbClient = await db;
    try {
      return await dbClient.insert(
        _tableName,
        task!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Insert error: $e");
      return -1;
    }
  }

  static Future<List<Task>> getTask() async {
    print("query funtion called");
    final Database dbClient = await db;
    final res = await dbClient.query(_tableName);
    return res.map((e) => Task.fromJson(e)).toList();
  }

  static Future<int> updateUser(Task task) async {
    final dbClient = await db;
    try {
      return await dbClient.update(
          _tableName, {'isCompleted': task.isCompleted = 1},
          where: 'id = ?', whereArgs: [task.id]);
    } catch (e) {
      print("Update error: $e");
      return -1;
    }
  }

  static Future<int> delete(Task task) async {
    final dbClient = await db;
    try {
      return await dbClient
          .delete(_tableName, where: 'id=?', whereArgs: [task.id]);
    } catch (e) {
      print("Delete error: $e");
      return -1;
    }
  }
  // static Future<void> initDb() async {
  //   if (_db != null) {
  //     return;
  //   }
  //   try {
  //     String _path = await getDatabasesPath() + '/todo.db';
  //     _db = await openDatabase(
  //     _path,
  //     onCreate: (db, version) async {
  //       await db.execute("CREATE TABLE $_tableName("
  //             "id INTEGER PRIMARY KEY AUTOINCREMENT, "
  //             "title TEXT, "
  //             "note TEXT, "
  //             "date STRING, "
  //             "startTime STRING, "
  //             "endTime STRING, "
  //             "color INTEGER, "
  //             "remind INTEGER, "
  //             "repeat STRING, "
  //             "isCompleted INTEGER)");
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<int> insert(Task? task) async {
  //   print("insert function called");
  //   try {
  //     return await _db!.insert(_tableName, task!.toJson());
  //   } catch (e) {
  //     print("Insert error: $e");
  //     print("_db is: $_db");

  //     return -1;
  //   }
  // }

  // static Future<List<Map<String, dynamic>>> query() async {
  //   print("query funtion called");
  //   return await _db!.query(_tableName);
  // }
}
