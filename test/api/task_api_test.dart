import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test_zoluxiones/api/task_api.dart';

import '../mocks.mocks.dart';

@GenerateMocks([TaskAPI])
void main() {
  late MockTaskAPI mockTaskAPI;

  setUp(() {
    mockTaskAPI = MockTaskAPI();
  });

  group('TaskAPI', () {
    test('Fetch tasks returns a list of tasks', () async {
      // Arrange
      final mockTasks = [
        {'id': 1, 'title': 'Task 1', 'completed': false},
        {'id': 2, 'title': 'Task 2', 'completed': true},
      ];
      when(mockTaskAPI.fetchTasks()).thenAnswer((_) async => mockTasks);

      // Act
      final tasks = await mockTaskAPI.fetchTasks();

      // Assert
      expect(tasks.length, 2);
      expect(tasks.first['title'], 'Task 1');
    });
  });
}
