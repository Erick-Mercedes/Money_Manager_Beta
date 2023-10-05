import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/Screens/ruta_setting/configuracion/Avatars/avatars_profile.dart';
import 'package:money_manager/data/utlity.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_manager/Comm/customTextFormField.dart';
import 'package:money_manager/DataBase/DBHelper.dart';
import 'package:money_manager/Models/UserModel.dart';
import 'package:money_manager/Screens/Login_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProfilePage());
}

// Pantalla principal de perfil
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String selectedAvatar = 'images/icons_avatars/0_0.png';

final List<String> imagePaths = [
  'images/icons_avatars/0.png',
  'images/icons_avatars/1.png',
  'images/icons_avatars/2.png',
  'images/icons_avatars/3.png',
  'images/icons_avatars/4.png',
  'images/icons_avatars/5.png',
];

// Variables para el almacenamiento local
class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final _formKey = GlobalKey<FormState>();
  late Future<SharedPreferences> _pref;
  late DbHelper dbHelper;

  // Controladores de texto para campos de entrada
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  // Variables para mostrar información de perfil
  String _followersCount = '\$ ${total()}';
  String _followingCount = '\$ ${expenses()}';
  String _favoritesCount = '\$ ${income()}';
  String _profileImage = logo;
  //String _direccion = "C/ Grupo #2";
  //String _telefono = "123-456-7890";

  // Color de fondo seleccionado
  Color _selectedColor = Colors.white; // Color predeterminado
  final List<Color> _availableColors = [
    blanco,
    rosado,
    rojo,
    deepOrange,
    orange,
    amarillo,
    verde,
    azul,
    deepPurple,
  ];

  // Método para cargar el color seleccionado desde SharedPreferences
  _loadSelectedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int colorIndex = prefs.getInt('selectedColor') ?? 0;
    setState(() {
      _selectedColor = _availableColors[colorIndex];
    });
  }

/**=========================================================================== 

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile.path;
      });

      // Guardar la ruta de la imagen localmente
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImage', _profileImage);
    }
  }*/

  // Inicialización del widget
  @override
  void initState() {
    super.initState();
    initSharedPreferences(); // Llama a initSharedPreferences en initState
    dbHelper = DbHelper();
    _loadSelectedColor();
    super.initState();
    loadSelectedAvatar();
    // Cargar la imagen de perfil almacenada localmente
    /*SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _profileImage = prefs.getString('profileImage') ?? _profileImage;
      });
    });*/
  }

  Future<void> loadSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedAvatar = prefs.getString('selectedAvatar') ?? selectedAvatar;
    setState(() {
      selectedAvatar = savedAvatar;
    });
  }

  /*Future<void> saveSelectedAvatar(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAvatar', imagePath);
  }*/

  // Inicialización de SharedPreferences
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

  // Obtener datos del usuario desde SharedPreferences
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

  // Actualizar datos del usuario
  Future<void> update() async {
    String uid = _conUserId.text; // Obtén el valor del campo "User ID"
    String uname = _conUserName.text; // Obtén el valor del campo "User Name"
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

  // Mostrar un diálogo de confirmación para la actualización
  Future<void> showUpdateConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // El usuario debe hacer clic en un botón para cerrar la alerta
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Actualización'),
          content: Text('¿Estás seguro de que deseas actualizar tus datos?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la alerta
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la alerta
                // Llama a la función de actualización aquí
                update();
              },
            ),
          ],
        );
      },
    );
  }

  // Eliminar la cuenta de usuario
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

  // Mostrar un diálogo de confirmación para la eliminación de la cuenta
  Future<void> showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Cierre de Sesión'),
          content: Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                // Llama a la función de cierre de sesión aquí
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  // Actualizar SharedPreferences con datos de usuario
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

  // Cerrar sesión del usuario
  Future<void> logout() async {
    // Aquí puedes realizar cualquier acción necesaria para cerrar la sesión,
    // como eliminar datos de SharedPreferences o realizar otras tareas de limpieza.
    // Luego, navega de regreso a la pantalla de inicio de sesión.
    final SharedPreferences sp = await _pref;
    sp.remove('user_id');
    sp.remove('user_name');
    sp.remove('email');
    sp.remove('password');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginForm()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),*/
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Perfil',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: _selectedColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: _selectedColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          //onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(selectedAvatar),
                            /*child: Icon(
                              Icons.camera_alt,
                              size: 40,
                            ),*/
                          ),
                        ),
                      ),
                      Text(
                        _conUserName.text, // Muestra el nombre del usuario
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Espacio entre el nombre y la tabla
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              _favoritesCount,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Ingresos',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              _followersCount,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              _followingCount,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Gastos',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Datos Personales.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.image_search), // Icono de un lápiz
                              onPressed: () {
                                // Aquí puedes realizar la navegación a la otra página
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AvatarSelectionPage();
                                    },
                                  ),
                                );
                              },
                            ),
                            // Retorna la página a la que deseas redirigir
                          ],
                        ),

                        /**------------------ */
                        Divider(
                          height: 20,
                          color: Colors.grey,
                        ),

                        TextFormField(
                          controller: _conDelUserId,
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.verified_user_outlined),
                            hintText: 'User ID',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        TextFormField(
                          controller: _conUserName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: 'User Name',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        TextFormField(
                          controller: _conEmail,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        TextFormField(
                          controller: _conPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint_outlined),
                            hintText: 'Password',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Container(
                          margin: EdgeInsets.all(15.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showUpdateConfirmationDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.all(15.0),
                            ),
                            child: Text('Update Date'),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        // Delete

                        TextFormField(
                          controller: _conDelUserId,
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.verified_user_outlined),
                            hintText: 'User ID',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: delete,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.all(15.0),
                            ),
                            child: Text('Delete Account'),
                          ),
                        ),

                        // Botón de Cerrar Sesión
                        Container(
                          margin: EdgeInsets.all(15.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showLogoutConfirmationDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Color de fondo del botón
                              onPrimary:
                                  Colors.white, // Color del texto en el botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.all(15.0),
                            ),
                            child: Text('Cerrar Sesión'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
