class UserModel {
  String user_id;
  String user_name;
  String email;
  String password;

  UserModel(this.user_id, this.user_name, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password
    };
    return map;
  }

  // Constructor de fábrica para crear una instancia UserModel desde un mapa.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['user_id'],
      map['user_name'],
      map['email'],
      map['password'],
    );
  }
}
