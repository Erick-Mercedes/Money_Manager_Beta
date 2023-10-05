import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:money_manager/widgets/setting/setting.dart';
import 'package:money_manager/widgets/setting/setting_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);
  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  AppBar buildAppBar(BuildContext context) {
    final icon = CupertinoIcons.moon_stars;

    return AppBar(
      leading: BackButton(
        color: Colors.grey,
      ),
      backgroundColor: _selectedColor,
      elevation: 0,
      /*actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
        color: Colors.grey,
      ),
    ],*/
    );
  }

/**============================Color de fondo================================ */
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

  @override
  void initState() {
    super.initState();
    _loadSelectedColor();
  }

  _loadSelectedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int colorIndex = prefs.getInt('selectedColor') ?? 0;
    setState(() {
      _selectedColor = _availableColors[colorIndex];
    });
  }

  _saveSelectedColor(int colorIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', colorIndex);
    setState(() {
      _selectedColor = _availableColors[colorIndex];
    });
  }

/**=========================================================================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: _selectedColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextConfig(),
                  const Divider(
                    thickness: 1,
                  ),
                  //Notificacion y Apatiencia
                  Column(
                    children: List.generate(
                      settings3.length,
                      (index) => SettingTile(setting: settings3[index]),
                    ),
                  ),

                  //Seguridad y privacidad
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings4.length,
                      (index) => SettingTile(setting: settings4[index]),
                    ),
                  ),

                  //Seguridad y privacidad
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings5.length,
                      (index) => SettingTile(setting: settings5[index]),
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

class TextConfig extends StatelessWidget {
  const TextConfig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 50,
          height: 100,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Configuración",
              style: TextStyle(
                fontSize: ksuperFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
