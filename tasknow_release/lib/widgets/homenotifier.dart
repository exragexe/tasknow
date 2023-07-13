import 'package:flutter/cupertino.dart';
import 'package:tasknow_release/widgets/database.dart';
import 'package:tasknow_release/widgets/task.dart';

class HomeNotifier extends ChangeNotifier {
  Color backgroundColor = const Color.fromARGB(255, 201, 201, 201);
  Color darkBackgroundColor = const Color.fromARGB(255, 81, 81, 81);
  bool _priorityEnabled = false;

  bool get priorityEnabled => _priorityEnabled;

  void setPriorityEnabled(bool value) {
    _priorityEnabled = value;
    notifyListeners();
  }

  void changeBackgroundColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }

   List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final database = DatabaseHelper.instance;
    _tasks = await database.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final database = DatabaseHelper.instance;
    await database.insertTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    final database = DatabaseHelper.instance;
    await database.deleteTask(task);
    _tasks.remove(task);
    notifyListeners();
  }
}
