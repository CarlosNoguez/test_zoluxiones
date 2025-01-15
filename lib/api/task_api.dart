import 'package:dio/dio.dart';

class TaskAPI {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
  );

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      final response = await _dio.get('/todos');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Failed to fetch tasks');
    }
  }
}
