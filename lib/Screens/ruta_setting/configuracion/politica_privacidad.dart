import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Política y Privacidad',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                logo, // Reemplaza 'assets/logo.png' con la ubicación de tu imagen de logo
                width: 100.0,
                height: 100.0,
              ),
              Text(
                'Money Manager',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Fecha de vigencia: 12 / 09 / 2023',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Esta Política de Privacidad describe cómo ANGEL ERICK recopila, utiliza y protege la información que usted proporciona cuando utiliza nuestra aplicación móvil MONEY MANAGER. Su privacidad es importante para nosotros, y nos comprometemos a proteger sus datos personales y financieros. Al utilizar nuestra aplicación, usted acepta las prácticas descritas en esta Política de Privacidad.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              // Continúa con el resto del texto de la política de privacidad aquí...
              /**-- Informacion que Recopilamos */
              SizedBox(height: 16.0),
              Text(
                'Información que recopilamos.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '1. Información de la cuenta:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '''
Cuando crea una cuenta en Money Manager, recopilamos su nombre, dirección de correo electrónico y contraseña para autenticación y gestión de su cuenta.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                '2. Información financiera:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '''
Para brindarle servicios de ahorro, Money Manager recopila información sobre sus transacciones financieras, saldos y actividades de ahorro.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),

              Text(
                '3. Información del dispositivo:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '''
Podemos recopilar información sobre su dispositivo móvil, incluidos el modelo, la versión del sistema operativo y la identificación única del dispositivo.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),

              Text(
                '4. Información de ubicación:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '''
Si concede permiso, podemos recopilar información de ubicación para proporcionar servicios basados en la ubicación, como ubicar sucursales cercanas.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Como usamos su informacion */
              SizedBox(height: 16.0),
              Text(
                'Cómo utilizamos su información.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Utilizamos la información que recopilamos para:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '''
  - Administrar y mantener su cuenta de usuario.
  - Procesar sus transacciones y ahorros.
  - Mejorar nuestros servicios y la experiencia del usuario.
  - Enviarle actualizaciones sobre su cuenta y servicios.
  - Cumplir con las leyes y regulaciones aplicables.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Seguridad */
              SizedBox(height: 16.0),
              Text(
                'Seguridad de la información.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '''
  La seguridad de su información es nuestra prioridad. Implementamos medidas de seguridad físicas, electrónicas y administrativas para proteger sus datos personales y financieros.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Divulgación de información */
              SizedBox(height: 16.0),
              Text(
                'Divulgación de información',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '''
  No vendemos ni compartimos su información personal con terceros no afiliados, excepto cuando sea necesario para prestar nuestros servicios o cumplir con las leyes y regulaciones aplicables.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Derechos */
              SizedBox(height: 10.0),
              Text(
                'Sus derechos y opciones.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '''
- Puede acceder, actualizar o corregir su información personal en la configuración de su cuenta.
- Puede optar por dejar de recibir comunicaciones promocionales por correo electrónico.
- Puede solicitar la eliminación de su cuenta y datos personales, sujeto a las leyes y regulaciones aplicables.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Cambios de Politicas*/
              SizedBox(height: 10.0),
              Text(
                'Cambios en esta Política de Privacidad.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '''
Podemos actualizar esta Política de Privacidad periódicamente. Se le notificarán los cambios significativos a través de la aplicación o por otros medios apropiados.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              /**-- Contacto*/
              SizedBox(height: 10.0),
              Text(
                'Contacto',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '''
  Si tiene alguna pregunta sobre esta Política de Privacidad o sobre cómo manejamos su información, comuníquese con nosotros en angel.emil@prueba.com.

  Gracias por confiar en Money Manager para sus necesidades de ahorro. Estamos comprometidos en proteger su privacidad y proporcionarle una experiencia segura y confiable.
            ''',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
