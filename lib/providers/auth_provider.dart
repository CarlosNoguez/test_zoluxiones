import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/auth_api.dart';
import '../services/secure_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) {
    return AuthNotifier(ref);
  },
);

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this._ref) : super(false);

  final Ref _ref;
  final AuthAPI _authAPI = AuthAPI();
  final SecureStorage _secureStorage = SecureStorage();

  Future<void> login(String email, String password) async {
    final token = await _authAPI.login(email, password);
    if (token != null) {
      await _secureStorage.saveToken(token);
      state = true;
    }
  }

  Future<void> register(String email, String password) async {
    final token = await _authAPI.register(email, password);
    if (token != null) {
      await _secureStorage.saveToken(token);
      state = true;
    }
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
    state = false;
  }

  Future<void> checkAuthStatus() async {
    final token = await _secureStorage.getToken();
    state = token != null;
  }
}
