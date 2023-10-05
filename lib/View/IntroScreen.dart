import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// Esta clase representa la pantalla de introducción.
class IntroScreen extends StatelessWidget {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const TextStyle titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle skipNextTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: primaryColor,
  );

  final List<PageViewModel> pages = [
    IntroPageModel(
      title: "Establecer Metas Financieras",
      body:
          "¿Tienes objetivos financieros específicos? Ya sea ahorrar para un viaje, comprar una casa o pagar deudas, te ayudaremos a establecer metas financieras claras y alcanzables.",
      imagePath: "assets/images/01.png",
    ).buildPage(),
    IntroPageModel(
      title: "Tu seguridad es prioridad",
      body:
          "Tu seguridad financiera es nuestra prioridad. No compartimos tu información de tus activos.",
      imagePath: "assets/images/02.png",
    ).buildPage(),
    IntroPageModel(
      title: "Presupuesto Personalizado",
      body:
          "Nuestro sistema te ayudará a analizar tus ingresos y gastos para crear un presupuesto personalizado. Saber en qué gastas tu dinero es fundamental para tomar decisiones financieras.",
      imagePath: "assets/images/03.png",
    ).buildPage(),
    IntroPageModel(
      title: "¡Comienza a Ahorrar Ahora!",
      body:
          "¡Bienvenido a Money Manager! Estamos emocionados de acompañarte en tu camino hacia la seguridad financiera y el éxito en el ahorro. ¡Comencemos a ahorrar juntos!.",
      imagePath: "assets/images/04.png",
    ).buildPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildIntroductionScreen(context),
    );
  }

  IntroductionScreen _buildIntroductionScreen(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      scrollPhysics: BouncingScrollPhysics(),
      pages: pages,
      onDone: () {
        _navigateTo(context, Routes.login);
      },
      onSkip: () {
        _navigateTo(context, Routes.login);
      },
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: skipNextTextStyle,
      ),
      next: Icon(
        Icons.arrow_forward,
        color: primaryColor,
      ),
      done: Text(
        "Done",
        style: skipNextTextStyle,
      ),
      dotsDecorator: DotsDecorator(
        size: Size.square(10.0),
        activeSize: Size(20.0, 10.0),
        color: Colors.black26,
        activeColor: primaryColor,
        spacing: EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.9),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}

/// Rutas de navegación utilizadas en la aplicación.

class Routes {
  static const String login = "login";
}

/// Representa una página de introducción con título, texto y una imagen.

class IntroPageModel {
  final String title;
  final String body;
  final String imagePath;

  IntroPageModel({
    required this.title,
    required this.body,
    required this.imagePath,
  });

  PageViewModel buildPage() {
    return PageViewModel(
      titleWidget: Text(
        title,
        style: IntroScreen.titleStyle,
      ),
      body: body,
      image: Image.asset(
        imagePath,
        height: 400,
        width: 400,
      ),
    );
  }
}
