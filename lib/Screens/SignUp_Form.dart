import 'package:flutter/material.dart';
import 'package:money_manager/Comm/comHelper.dart';
import 'package:money_manager/Comm/genLoginSignupHeader.dart';
import 'package:money_manager/Comm/customTextFormField.dart';
import 'package:money_manager/DataBase/DBHelper.dart';
import 'package:money_manager/Models/UserModel.dart';
import 'package:money_manager/Screens/Login_Form.dart';
//import 'package:toast/toast.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

// Define el validador personalizado
String? _validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }
  return null;
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String c_passwd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != c_passwd) {
        //alertDialog(context, "Password Mismatch");
      } else {
        // Verifica si el UserId ya está en uso
        bool isUserIdTaken = await dbHelper.isUserIdTaken(uid);

        if (isUserIdTaken) {
          // El UserId ya está en uso, muestra una notificación y sugerencias
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('El UserId ya está en uso. Por favor, elige otro.'),
            ),
          );
        } else {
          _formKey.currentState!.save();

          UserModel uModel = UserModel(uid, uname, email, passwd);
          await dbHelper.saveData(uModel).then((userData) {
            //alertDialog(context, "Successfully Saved");

            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginForm()));
          }).catchError((error) {
            print(error);
            //alertDialog(context, "Error: Data Save Fail");
          });
        }
      }
    }
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    genLoginSignupHeader(""),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomTextFormField(
                      controller: _conUserId,
                      icon: Icons.verified_user_outlined,
                      hintName: 'User ID',
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      controller: _conUserName,
                      icon: Icons.account_circle_outlined,
                      inputType: TextInputType.name,
                      hintName: 'User Name',
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      controller: _conEmail,
                      icon: Icons.email_outlined,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email',
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      controller: _conPassword,
                      icon: Icons.fingerprint_outlined,
                      hintName: 'Password',
                      isObscureText: true,
                      customValidator: _validateEmpty, // Aplicar validación
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      controller: _conCPassword,
                      icon: Icons.password_outlined,
                      hintName: 'Confirm Password',
                      isObscureText: true,
                      customValidator: _validateEmpty, // Aplicar validación
                    ),

                    //Button login
                    Container(
                      margin: EdgeInsets.all(15.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                        ),
                        child: Text('SignUp'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                (Route<dynamic> Route) => false);
                          },
                          child: Text(
                            'Sign In',
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
