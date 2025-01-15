import 'package:dio/dio.dart';

class AuthAPI {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://reqres.in/api'),
  );

  Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data['token'];
    } catch (e) {
      return null;
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data['token'];
    } catch (e) {
      return null;
    }
  }
}
