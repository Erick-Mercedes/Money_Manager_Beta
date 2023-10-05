import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money_manager/View/IntroScreen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _logoVisible = false; // Variable para controlar la visibilidad del logo

  @override
  void initState() {
    super.initState();

    // Simula una carga ficticia
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _logoVisible = true; // Muestra el logo después de la carga ficticia
      });

      // Agrega una animación antes de redirigir a la siguiente página
      Future.delayed(const Duration(seconds: 1), () {
        // Utiliza una animación para redirigir a IntroScreen
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: IntroScreen(),
              );
            },
            //transitionDuration: Duration(seconds: 1), // Duración de la animación de transición
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.blue, // Cambia el color de fondo según tus preferencias
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Espacio para el logo
            SizedBox(height: 150.0), // Ajusta la distancia hacia arriba
            AnimatedOpacity(
              opacity:
                  _logoVisible ? 1.0 : 0.0, // Controla la opacidad del logo
              duration:
                  Duration(seconds: 1), // Duración de la animación del logo
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/logo.png'), // Logo final
                  ),
                ),
              ),
            ),
            // Espacio para el nombre del logo y la imagen
            SizedBox(height: 350.0),
            AnimatedOpacity(
              opacity: _logoVisible
                  ? 1.0
                  : 0.0, // Controla la opacidad del nombre del logo
              duration: Duration(
                  seconds: 1), // Duración de la animación del nombre del logo
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo.png', // Ruta de la imagen que desees mostrar al lado del nombre
                    width: 20.0, // Ancho de la imagen
                    height: 20.0, // Alto de la imagen
                  ),
                  SizedBox(width: 10.0), // Espacio entre el texto y la imagen
                  Text(
                    'Money Manager', // Reemplaza con el nombre de tu logo
                    style: TextStyle(
                      fontSize: 15.0, // Tamaño de fuente del nombre del logo
                      color: Colors.white, // Color del nombre del logo
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


            /*/ Espacio para la animación de carga
            SizedBox(height: 20.0),
            _logoVisible
                ? SpinKitCircle(
                    color: Colors
                        .white, // Cambia el color de la animación de carga según tus preferencias
                    size: 50.0,
                  )
                : SizedBox(), // Oculta la animación de carga cuando el logo está visible*/