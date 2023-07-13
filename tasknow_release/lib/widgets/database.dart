import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:tasknow_release/widgets/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    
    final path = await getDatabasesPath();
    final databasePath = join(path, 'tasks.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            time TEXT,
            info TEXT,
            created TEXT
          )
        ''');
      },
    );
    
  }

  Future<List<Task>> getTasks() async {
  final db = await database;
  final maps = await db.query('tasks');

  return List.generate(maps.length, (index) {
    return Task(
      id: maps[index]['id'].toString(),
      date: maps[index]['date'].toString(),
      time: maps[index]['time'].toString(),
      info: maps[index]['info'].toString(),
      created: maps[index]['created'].toString(),
    );
  });
}



  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert('tasks', task.toMap());
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;

    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
  }
}
