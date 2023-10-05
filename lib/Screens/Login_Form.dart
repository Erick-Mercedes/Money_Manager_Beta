import 'package:flutter/material.dart';
import 'package:money_manager/Comm/comHelper.dart';
import 'package:money_manager/Comm/customTextFormField.dart';
import 'package:money_manager/Comm/genLoginSignUpHeader.dart';
//import 'package:money_manager/Comm/genTextFormField.dart';
import 'package:money_manager/DataBase/DBHelper.dart';
import 'package:money_manager/Models/UserModel.dart';
import 'package:money_manager/Screens/SignUp_Form.dart';
import 'package:money_manager/widgets/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeForm.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  int _loginAttempts = 0;

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _conUserId;
  late final TextEditingController _conPassword;

  var dbHelper;

  @override
  void initState() {
    super.initState();
    _conUserId = TextEditingController();
    _conPassword = TextEditingController();
    dbHelper = DbHelper();
  }

  // Validador para verificar si el campo está vacío
  String? _validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  // Create Login Function
  login() async {
    if (_formKey.currentState!.validate()) {
      String uid = _conUserId.text;
      String passwd = _conPassword.text;

      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          // Restablece los intentos fallidos si el inicio de sesión es exitoso
          _loginAttempts = 0;

          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Bottom()),
              (Route<dynamic> route) => false,
            );
          });
        } else {
          _loginAttempts++; // Incrementa el contador de intentos fallidos
          if (_loginAttempts >= 3) {
            // Bloquea la cuenta después de 3 intentos fallidos
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Cuenta bloqueada"),
                  content: Text(
                      "Tu cuenta ha sido bloqueada debido a demasiados intentos fallidos."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Aceptar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            // Muestra una alerta de intento fallido
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error de inicio de sesión"),
                  content: Text(
                      "Las credenciales ingresadas son incorrectas. Intentos restantes: ${3 - _loginAttempts}"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Aceptar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      }).catchError((error) {
        print(error);
        // alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Añade esta línea para hacer que el Container ocupe toda la pantalla
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey,
            ], // Cambia estos colores según tus preferencias
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.0),
                    SizedBox(height: 30.0),
                    genLoginSignupHeader(""),
                    SizedBox(height: 10.0),
                    CustomTextFormField(
                      controller: _conUserId,
                      icon: Icons.verified_user_outlined,
                      hintName: 'User ID',
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    SizedBox(height: 10.0),
                    CustomTextFormField(
                      controller: _conPassword,
                      icon: Icons.fingerprint_outlined,
                      hintName: 'Password',
                      isObscureText: true,
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                        ),
                        child: Text('Login'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Does Not Have Account?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignupForm()),
                            );
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
