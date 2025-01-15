import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/task_api.dart';
import '../models/task.dart';
import '../services/connectivity_service.dart';
import '../services/local_storage.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) {
    return TaskNotifier();
  },
);

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadLocalTasks();
  }

  final TaskAPI _taskAPI = TaskAPI();
  final LocalStorage _localStorage = LocalStorage();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> _loadLocalTasks() async {
    final localTasks = _localStorage.getAllTasks();
    state = localTasks;
  }

  Future<void> fetchTasks() async {
    try {
      final tasks = await _taskAPI.fetchTasks();
      final taskList = tasks.map((task) => Task.fromJson(task)).toList();
      state = taskList;
      for (var task in taskList) {
        await _localStorage.addTask(task);
      }
    } catch (e) {}
  }

  void addTask(Task task) {
    state = [...state, task];
    _localStorage.addTask(task);
  }

  void updateTask(Task updatedTask) {
    state = state
        .map((task) => task.id == updatedTask.id ? updatedTask : task)
        .toList();
    _localStorage.updateTask(updatedTask);
  }

  void deleteTask(int id) {
    state = state.where((task) => task.id != id).toList();
    _localStorage.deleteTask(id);
  }

  Future<void> syncTasks() async {
    final tasksToSync = _localStorage.getAllTasks();
    for (var task in tasksToSync) {}
  }

  Future<void> autoSync() async {
    if (await _connectivityService.isConnected()) {
      await syncTasks();
    }
  }

  void updateTaskStatus(int taskId, bool isCompleted) {
    state = state.map((task) {
      if (task.id == taskId) {
        return Task(
          id: task.id,
          title: task.title,
          description: task.description,
          isCompleted: isCompleted,
        );
      }
      return task;
    }).toList();
  }
}
