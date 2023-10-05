import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Money Manager',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AcercaNameColor,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Versión 1.0.0 (Beta)',
                style: TextStyle(
                  fontSize: 18.0,
                  color: VersionAnual,
                ),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                logo, // Reemplaza 'assets/logo.png' con la ubicación de tu imagen de logo
                width: 100.0,
                height: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                '© 2023-2024',
                style: TextStyle(
                  fontSize: 16.0,
                  color: VersionAnual,
                ),
              ),
              SizedBox(height: 20.0),
              /*FlatButton(
                onPressed: () {
                  // Navegar a la página de licencia
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicensePage(),
                    ),
                  );
                },
                child: Text(
                  'Licencia',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class LicensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Licencia'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Text(
          // Agrega aquí el texto de la licencia de tu aplicación
          'Este es el texto de la licencia de la aplicación Money Manager...',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
