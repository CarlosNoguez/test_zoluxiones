import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_zoluxiones/models/task.dart';
import 'screens/add_task_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/edit_task_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/task_details_screen.dart';
import 'screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(
    TaskAdapter(),
  );
  await Hive.openBox<Task>('tasks');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test_zoluxiones',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/tasks': (context) => TaskListScreen(),
        '/task-details': (context) => TaskDetailsScreen(
              task: ModalRoute.of(context)!.settings.arguments as Task,
            ),
        '/add-task': (context) => const AddTaskScreen(),
        '/edit-task': (context) => EditTaskScreen(
              task: ModalRoute.of(context)!.settings.arguments as Task,
            ),
      },
    );
  }
}
