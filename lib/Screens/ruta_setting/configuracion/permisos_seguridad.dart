import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationPage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}*/

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  /**============================Color de fondo================================ */
  Color _selectedColor = Colors.white; // Color predeterminado
  final List<Color> _availableColors = [
    blanco,
    rosado,
    rojo,
    deepOrange,
    orange,
    amarillo,
    verde,
    azul,
    deepPurple,
  ];

  _loadSelectedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int colorIndex = prefs.getInt('selectedColor') ?? 0;
    setState(() {
      _selectedColor = _availableColors[colorIndex];
    });
  }

  _saveSelectedColor(int colorIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', colorIndex);
    setState(() {
      _selectedColor = _availableColors[colorIndex];
    });
  }

/**=========================================================================== */
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool notificationsEnabled = true;
  bool storagePermissionsEnabled = false;

  @override
  void initState() {
    _loadSelectedColor();
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Verificar el estado actual de los permisos de almacenamiento
    _checkStoragePermissionStatus();
  }

  // Método para verificar el estado de los permisos de almacenamiento
  _checkStoragePermissionStatus() async {
    var status = await Permission.storage.status;
    setState(() {
      storagePermissionsEnabled = status.isGranted;
    });
  }

  // Método para solicitar los permisos de almacenamiento
  _requestStoragePermissions() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permisos de almacenamiento otorgados
      setState(() {
        storagePermissionsEnabled = true;
      });
      // Aquí puedes mostrar el aviso de que los permisos de almacenamiento están activados
      _showStoragePermissionDialog();
    } else if (status.isPermanentlyDenied) {
      // El usuario ha rechazado permanentemente los permisos, puedes mostrar un diálogo o redirigirlos a la configuración de la aplicación
      openAppSettings();
    } else {
      // El usuario ha rechazado los permisos, maneja la lógica adecuada aquí
    }
  }

  // Método para mostrar el aviso de permisos de almacenamiento activados
  _showStoragePermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permisos de Almacenamiento.'),
          content:
              Text('Money Manager ahora tiene permiso a tu almacenamiento.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Permisos y Seguridad',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: _selectedColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: _selectedColor,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Notificaciones',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Almacenamiento',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: storagePermissionsEnabled,
                        onChanged: (value) {
                          if (value) {
                            _requestStoragePermissions();
                          } else {
                            // Puedes implementar aquí la lógica para revocar los permisos de almacenamiento si es necesario
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            /*ElevatedButton(
              onPressed: () async {
                if (notificationsEnabled) {
                  var status = await Permission.notification.request();
                  if (status.isGranted) {
                    _showNotification();
                  } else {
                    // El usuario no otorgó permisos de notificación, maneja la lógica adecuada aquí
                  }
                } else {
                  // Las notificaciones están desactivadas, muestra un mensaje o maneja la lógica según sea necesario
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: Text(
                'Enviar Notificación',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Título de la notificación',
      'Cuerpo de la notificación',
      platformChannelSpecifics,
    );
  }
}
