import 'package:flutter/material.dart';
import 'package:money_manager/Comm/customTextFormField.dart';
import 'package:money_manager/DataBase/DBHelper.dart';
import 'package:money_manager/Models/UserModel.dart';
import 'package:money_manager/Screens/Login_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

String? _validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }
  return null;
}

class _HomeFormState extends State<HomeForm> {
  final _formKey = GlobalKey<FormState>();
  late Future<SharedPreferences> _pref;
  late DbHelper dbHelper;

  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPreferences(); // Llama a initSharedPreferences en initState
    dbHelper = DbHelper();
  }

  Future<void> initSharedPreferences() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _pref = Future.value(sharedPreferences);
      });
      getUserData();
    } catch (e) {
      // Maneja el error de alguna manera, como mostrando un mensaje al usuario o registrándolo para depuración.
      print('Error al obtener SharedPreferences: $e');
    }
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
      _conDelUserId.text = sp.getString("user_id")!;
      _conUserName.text = sp.getString("user_name")!;
      _conEmail.text = sp.getString("email")!;
      _conPassword.text = sp.getString("password")!;
    });
  }

  Future<void> update() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserModel user = UserModel(uid, uname, email, passwd);
      int value = await dbHelper.updateUser(user);

      if (value == 1) {
        updateSP(user, true).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginForm()),
              (Route<dynamic> route) => false);
        });
      } else {
        // Maneja el error de actualización
      }
    }
  }

  Future<void> delete() async {
    String delUserID = _conDelUserId.text;
    int value = await dbHelper.deleteUser(delUserID);

    if (value == 1) {
      updateSP(UserModel("", "", "", ""), false).whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginForm()),
            (Route<dynamic> route) => false);
      });
    } else {
      // Maneja el error de eliminación
    }
  }

  Future<void> updateSP(UserModel user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user.user_name);
      sp.setString("email", user.email);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Update
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
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: update,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),

                  // Delete

                  CustomTextFormField(
                    controller: _conUserId,
                    icon: Icons.verified_user_outlined,
                    hintName: 'User ID',
                    customValidator: _validateEmpty, // Aplicar validación
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: delete,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
