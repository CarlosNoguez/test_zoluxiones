# **Task Manager App**

Aplicación móvil desarrollada con Flutter que permite gestionar tareas de manera eficiente. Integra autenticación, soporte offline, notificaciones push y sincronización automática.

> **Nota:** Esta aplicación es muy sencilla, sin mucho diseño, únicamente enfocada en funcionalidad para evitar plagio y garantizar que se evalúe el trabajo del desarrollador de manera justa.

---

## **Características**

### **Autenticación**
- Login y registro utilizando la API [ReqRes](https://reqres.in/).
- Almacenamiento seguro del token JWT con `flutter_secure_storage`.

### **Gestión de Tareas**
- CRUD de tareas utilizando la API [JSONPlaceholder](https://jsonplaceholder.typicode.com/).
- Simulación de creación, edición y eliminación offline.

### **Notificaciones Push**
- Configuración de notificaciones push con Firebase Cloud Messaging (FCM).

### **Soporte Offline**
- Almacenamiento local de tareas utilizando Hive.

### **Interfaz de Usuario**
- Diseño básico y funcional.
- Pantallas clave:
  - Login y registro.
  - Dashboard con resumen de tareas.
  - Lista de tareas.
  - Detalles de tarea (ver, editar, eliminar).

---

## **Requisitos**

- **Flutter SDK**: Versión 3.10 o superior.
- **Android Studio** o **Xcode** instalado.
- Configuración de Firebase para notificaciones push.

---

## **Instalación**

1. Clona este repositorio:
   ```bash
   git clone https://github.com/CarlosNoguez/test_zoluxiones.git
   cd task-manager-app
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Configura Firebase:
   - **Android**: Coloca el archivo `google-services.json` en el directorio `android/app/`.
   - **iOS**: Coloca el archivo `GoogleService-Info.plist` en el directorio `ios/Runner/`.

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---

## **Estructura del Proyecto**

```plaintext
lib/
├── api/               # Lógica de interacción con APIs externas (ReqRes, JSONPlaceholder)
├── models/            # Modelos de datos (Task, User)
├── providers/         # Gestión del estado con Riverpod
├── screens/           # Pantallas principales (Login, Dashboard, etc.)
├── services/          # Servicios auxiliares (conectividad, almacenamiento local)
└── main.dart          # Punto de entrada de la aplicación
```

---

## **Uso**

### **Login y Registro**
- Inicia sesión con las credenciales proporcionadas por la API ReqRes:
  ```json
  {
    "email": "eve.holt@reqres.in",
    "password": "cityslicka"
  }
  ```
- Regístrate con un correo electrónico y contraseña válidos.

### **Gestión de Tareas**
- **Agregar tarea**: Navega a `/add-task` para crear una nueva tarea.
- **Editar tarea**: Selecciona una tarea existente y edítala en `/edit-task`.
- **Eliminar tarea**: Elimina una tarea desde su pantalla de detalles.

---

## **Pruebas**

### **Pruebas Unitarias**
Ejecuta pruebas unitarias para servicios y lógica principal:
```bash
flutter test
```

### **Pruebas de Integración**
Ejecuta pruebas de flujo completo:
```bash
flutter drive --target=integration_test/auth_flow_test.dart
```

---

## **To-Do**

- Implementar roles de usuario para restringir el acceso.
- Optimizar la sincronización de datos offline.
- Internalizacion de lenguaje.

---

## **Licencia**

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## **Autor**

Desarrollado por **Carlos Noguez**.

