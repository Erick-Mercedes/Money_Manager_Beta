//import 'dart:ffi';

import 'package:money_manager/Models/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version =
      2; // Incrementar la versión al realizar cambios en la estructura de la base de datos.

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database> getDatabase() async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  //Para llamar a la BD
  /*var dbHelper = DbHelper();
var database = await dbHelper.getDatabase();*/

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path,
        version: Version,
        onCreate: _onCreate,
        onUpgrade:
            _onUpgrade); // Agregar manejo de actualización de la base de datos.
    return db;
  }

  //Create Table

  Future<void> _onCreate(Database db, int intversion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT PRIMARY KEY, " //Agregar Primary Key
        " $C_UserName TEXT, "
        " $C_Email TEXT, "
        " $C_Password TEXT"
        ")");

    //Agrega índices: Crea un índice en la columna user_id ya que es la clave primaria de la tabla "user" y probablemente se utilice con frecuencia en consultas de búsqueda.
    await db.execute("CREATE INDEX idx_user_id ON $Table_User ($C_UserID)");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Agregar código para actualizar la estructura de la base de datos si es necesario.
    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("ALTER TABLE $Table_User ADD COLUMN new_column TEXT");
    }
  }

  //Create save user

  Future<int> saveData(UserModel user) async {
    try {
      var dbCliente = await getDatabase();
      var res = await dbCliente.insert(Table_User, user.toMap());
      return res;
    } catch (e) {
      print("Error al guardar datos en la base de datos: $e");
      return -1; // Valor de retorno que indica un error
    }
  }

  /*Future<int> saveData(UserModel user) async {
    var dbCliente = await getDatabase();
    var res = await dbCliente.insert(Table_User, user.toMap());
    return res;
  }*/

  //Get User Data

  Future<bool> isUserIdTaken(String userId) async {
    final db =
        await getDatabase(); // Utiliza la instancia de la base de datos _db
    final result =
        await db.query(Table_User, where: '$C_UserID = ?', whereArgs: [userId]);
    return result.isNotEmpty;
  }

  //Utiliza consultas parametrizadas: En lugar de utilizar consultas SQL crudas en rawQuery, utiliza consultas parametrizadas con query para prevenir la inyección de SQL y mejorar la seguridad y el rendimiento de las consultas.

  Future<UserModel?> getLoginUser(String userId, String password) async {
    final db = await getDatabase();
    final result = await db.query(
      Table_User,
      where: '$C_UserID = ? AND $C_Password = ?',
      whereArgs: [userId, password],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbCliente = await getDatabase();
    var res = await dbCliente.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbCliente = await getDatabase();
    var res = await dbCliente
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  Future<void> closeDb() async {
    var dbCliente = await getDatabase();
    dbCliente.close(); // Cerrar la base de datos cuando ya no se necesite.
  }
}

/*
Estas son las mejoras y consideraciones aplicadas al código:

Incremento de la versión de la base de datos para manejar actualizaciones de la estructura.
Agregado de PRIMARY KEY en la columna C_UserID.
Uso de consultas parametrizadas para prevenir SQL injection.
Agregado de la función _onUpgrade para manejar actualizaciones de la estructura de la base de datos.
Agregado de la función closeDb para cerrar la base de datos cuando ya no se necesite.
Estas mejoras hacen que tu base de datos sea más segura y flexible para futuras actualizaciones de la estructura.
*/