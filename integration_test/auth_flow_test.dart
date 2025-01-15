import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_zoluxiones/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Authentication flow test', (WidgetTester tester) async {
    // Inicia la app
    app.main();
    await tester.pumpAndSettle();

    // Encuentra y llena el formulario de login
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verifica que el dashboard se muestra
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
