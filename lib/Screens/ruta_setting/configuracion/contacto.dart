import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/widgets/setting/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactPage(),
    );
  }
}

class ContactPage extends StatelessWidget {
  final String pageTitle = 'Contáctanos';
  final String emailAddress = 'angel.emil@example.com';
  final String whatsappNumber = '+1234567890';
  final String telegramUsername = '@telegramuser';
  final String youtubeChannel = 'youtube.com/@angelemil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          pageTitle,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(contactos),
              ),
              ContactCard(
                title: 'Correo Electrónico',
                data: emailAddress,
                showCopyIcon: true,
                gradientColors: [
                  Colors.red,
                  Colors.white
                ], // Colores de degradado
              ),
              ContactCard(
                title: 'WhatsApp',
                data: whatsappNumber,
                showCopyIcon: true,
                gradientColors: [
                  Colors.green,
                  Colors.yellow
                ], // Colores de degradado
              ),
              ContactCard(
                title: 'Telegram',
                data: telegramUsername,
                showCopyIcon: true,
                gradientColors: [
                  Colors.blue,
                  Colors.green
                ], // Colores de degradado
              ),
              ContactCard(
                title: 'YouTube',
                data: youtubeChannel,
                showCopyIcon: true,
                gradientColors: [
                  Colors.blue,
                  Colors.red,
                ], // Colores de degradado
              ),
              // Puedes agregar más ContactCard aquí
            ],
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String title;
  final String data;
  final bool showCopyIcon;
  final List<Color> gradientColors; // Colores de degradado

  ContactCard(
      {required this.title,
      required this.data,
      this.showCopyIcon = false,
      this.gradientColors = const []});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors, // Aplicar el degradado de colores
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Copiar al portapapeles cuando se toque
                  Clipboard.setData(ClipboardData(text: data));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copiado al portapapeles: $data'),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    if (showCopyIcon) SizedBox(width: 10),
                    if (showCopyIcon) Icon(Icons.copy),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
