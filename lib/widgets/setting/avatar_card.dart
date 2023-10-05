import 'package:flutter/material.dart';
import 'package:money_manager/data/utlity.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:money_manager/Comm/customTextFormField.dart';
import 'package:money_manager/DataBase/DBHelper.dart';
import 'package:money_manager/Models/UserModel.dart';
import 'package:money_manager/Screens/Login_Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({Key? key}) : super(key: key);

  @override
  State<AvatarCard> createState() => _AvatarState();
}
/*class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
  });
}*/

String selectedAvatar = 'images/icons_avatars/0_0.png';

final List<String> imagePaths = [
  'images/icons_avatars/0.png',
  'images/icons_avatars/1.png',
  'images/icons_avatars/2.png',
  'images/icons_avatars/3.png',
  'images/icons_avatars/4.png',
  'images/icons_avatars/5.png',
];

class _AvatarState extends State<AvatarCard> {
  final _formKey = GlobalKey<FormState>();
  late Future<SharedPreferences> _pref;
  late DbHelper dbHelper;

  final TextEditingController _conUserName = TextEditingController();
  @override
  void initState() {
    initSharedPreferences(); // Llama a initSharedPreferences en initState
    dbHelper = DbHelper();
    loadSelectedAvatar();
    super.initState();
    //_loadSelectedColor();
  }

  Future<void> loadSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedAvatar = prefs.getString('selectedAvatar') ?? selectedAvatar;
    setState(() {
      selectedAvatar = savedAvatar;
    });
  }

  Future<void> saveSelectedAvatar(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAvatar', imagePath);
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
      _conUserName.text = sp.getString("user_name")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          selectedAvatar,
          width: 60,
          height: 60,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _conUserName.text,
              style: TextStyle(
                fontSize: knormalFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              'Balance \$ ${total()}',
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
