import 'package:hive/hive.dart';
import '../models/task.dart';

class LocalStorage {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  List<Task> getAllTasks() {
    return _taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> deleteTask(int id) async {
    await _taskBox.delete(id);
  }

  Future<void> clearAllTasks() async {
    await _taskBox.clear();
  }
}
