import 'package:sqflite/sqflite.dart';

import '../models/task.dart';
import 'package:path/path.dart';

class DBHelper {
   static Database? _db;
  static const String tableName = 'Task';


  static creatDatabase() async
  {
    _db = await openDatabase('tasks.db', version: 1,

        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          print('db created');
          await db.execute(
              'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'title TEXT,note TEXT, isComplete INTEGER,date TEXT,'
                  'startTime TEXT,endTime TEXT ,color INTEGER,remind INTEGER, repeat TEXT)'
          );
        }, onOpen: (Database db) {
          print('opend database');
          ;
        }
    );

    // static Future<void> initDB() async {
    //   if (  _db != null) {
    //     print('we have  database no need for creating');
    //     return;
    //   } else {
    //     print('creating database');
    //       var DBpath = await getDatabasesPath();
    //       String _path = join( await DBpath, 'note.db');
    //
    //       Database _db= await openDatabase(_path, version: 1,
    //           onCreate: (Database db, int version) async {
    //         // When creating the db, create the table
    //         await db.execute(
    //             'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
    //             'title TEXT,note TEXT, isComplete INTEGER,date TEXT,'
    //             'startTime TEXT,endTime TEXT ,color INTEGER,remind INTEGER, repeat TEXT)'
    //         );
    //       },onOpen: (Database db){
    //         print('opend database');
    //           });
    //
    //   }
    // }

    if (_db != null)
      print('we have database');
  }
    Future<int> insertNote(Task? task) async {
    print('insert to DB');
      return _db!.insert(tableName, task!.toJson());
    }

    Future<int> deleteNote(Task task) async {
      return _db!.delete(tableName, where: 'id=?', whereArgs: [task.id]);
    }

    Future<int> deleteAll(Task task) async {
      return _db!.rawDelete(tableName);
    }

    // Future<int> updateNote(int id, String title, String note) async {
    //   return await db!.rawUpdate(
    //       '''UPDATE $tableName
    //       SET isComplete = ?,
    //       title = ?,
    //       note = ?
    //       WHERE id = ?''',
    //       [1, title, note]);
    // }

    Future<int> updateNote(int id) async {
      return await _db!.rawUpdate(
          '''UPDATE $tableName 
        SET isComplete = ?,
        WHERE id = ?''',
          [1, id]);
    }

    Future <List<Map<String, dynamic>>> getAllNotes() async {
      return await _db!.query(tableName);
    }
  }

