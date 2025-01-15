import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test_zoluxiones/api/auth_api.dart';

import '../mocks.mocks.dart';

@GenerateMocks([AuthAPI])
void main() {
  late MockAuthAPI mockAuthAPI;

  setUp(() {
    mockAuthAPI = MockAuthAPI();
  });

  group('AuthAPI', () {
    test('Login returns token on success', () async {
      // Arrange
      when(mockAuthAPI.login('test@example.com', 'password'))
          .thenAnswer((_) async => 'mock-token');

      // Act
      final token = await mockAuthAPI.login('test@example.com', 'password');

      // Assert
      expect(token, 'mock-token');
    });

    test('Login returns null on failure', () async {
      // Arrange
      when(mockAuthAPI.login('test@example.com', 'wrong-password'))
          .thenAnswer((_) async => null);

      // Act
      final token = await mockAuthAPI.login('test@example.com', 'wrong-password');

      // Assert
      expect(token, isNull);
    });
  });
}
