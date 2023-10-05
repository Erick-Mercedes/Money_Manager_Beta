import 'package:flutter/material.dart';
import 'package:money_manager/Screens/Login_Form.dart';
import 'package:money_manager/Screens/SignUp_Form.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/Avatars/avatars_profile.dart';
import 'package:money_manager/View/splash_view.dart';
import 'package:money_manager/widgets/setting/avatar_card.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Models/UserModel.dart';
import 'DataBase/DBHelper.dart';
//import 'package:flutter/material.dart';
//librerias del proyecto
import 'package:get/get.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/apariencia.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/permisos_seguridad.dart';
import 'package:money_manager/View/IntroScreen.dart';
import 'package:money_manager/Screens/ruta_setting/acerca_de.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/calificanos.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/contacto.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/politica_privacidad.dart';
import 'package:money_manager/Screens/ruta_setting/divisas.dart';
import 'package:money_manager/Screens/ruta_setting/faq.dart';
import 'package:money_manager/Screens/ruta_setting/profile_page.dart';
import 'package:money_manager/Screens/ruta_setting/referidos.dart';
import 'package:money_manager/widgets/bottomnavigationbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/model/add_date.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar la base de datos
  final dbHelper = DbHelper();
  await dbHelper.initDb();
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Manager',
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      debugShowCheckedModeBanner: false,
      routes: {
        //"/": (context) => SplashView(),
        "/": (context) => IntroScreen(),
        "login": (context) => LoginForm(),
        "Register": (context) => SignupForm(),

        /*Routes: Emil*/
        "Bottom": (context) => Bottom(),
        '/datos-personales': (context) => ProfilePage(),
        '/configuracion': (context) => ConfiguracionPage(),
        //'/avatar': (context) => AvatarSelectionPage(),
        '/referencia': (context) => ReferralPage(),
        '/divisas': (context) => Divisa(),
        '/preguntas': (context) => FaqPage(),
        '/acerca-de': (context) => AboutPage(),

        /**-- Configuracion */
        '/permisos': (context) => NotificationPage(),
        '/temas': (context) => ColorSelectionPage(),
        '/privacidad': (context) => PrivacyPage(),
        '/calificar': (context) => RatingPage(),
        '/contacto': (context) => ContactPage(),
      },
    );
  }
}
