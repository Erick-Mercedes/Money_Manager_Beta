import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReferralPage(),
    );
  }
}

class ReferralPage extends StatelessWidget {
  final String referralLink = "https://www.youtube.com/@angelemil";
  final String description =
      "¡Ahora invitar a tus amigos es mas facil!\n\nInvitar a tus amigos a esta plataforma les brindara una mayor experiencia y conocimiento del manejo de sus finanzas.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitar amigos'),
        backgroundColor:
            Colors.white, // Fondo blanco para la barra de navegación
        foregroundColor:
            Colors.black, // Texto negro para la barra de navegación
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/referido.png', // Reemplaza 'your_image.png' con la ruta de tu imagen
              height:
                  260, // Ajusta la altura de la imagen según tus necesidades
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Enlace de invitacion:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    referralLink,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: referralLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Enlace copiado al portapapeles'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Fondo blanco
                      onPrimary: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Borde redondeado
                      ),
                    ),
                    child: Text('Copiar Enlace'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
