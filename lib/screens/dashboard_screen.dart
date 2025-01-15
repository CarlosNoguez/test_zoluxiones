import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    _registerDeviceToken();
    _configureFCMListeners();
  }

  // Solicitar permisos de notificación
  void _requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not granted permission');
    }
  }

  // Obtener y registrar el token FCM
  void _registerDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
    // Aquí puedes enviar el token al backend si es necesario.
  }

  // Configurar listeners de notificaciones
  void _configureFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      if (message.data.isNotEmpty) {
        final taskId = message.data['taskId'];
        final status = message.data['status'];
        print('Task ID: $taskId, Status: $status');

        // Actualiza la tarea localmente si se proporcionan datos
        if (taskId != null && status != null) {
          ref.read(taskProvider.notifier).updateTaskStatus(
            int.parse(taskId),
            status == 'completed',
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked! Navigating...');
      // Maneja la navegación o lógica al abrir la app desde una notificación.
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(authProvider);
    final tasks = ref.watch(taskProvider);

    // Contar tareas completadas y pendientes
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final pendingTasks = tasks.length - completedTasks;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, '/'); // Redirige al login.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mensaje de bienvenida
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            // Resumen de tareas
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Summary',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$completedTasks',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.green),
                            ),
                            const Text('Completed'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '$pendingTasks',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                            const Text('Pending'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón para ver lista de tareas
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/tasks'); // Navegar a TaskListScreen.
              },
              icon: const Icon(Icons.list),
              label: const Text('View Tasks'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
