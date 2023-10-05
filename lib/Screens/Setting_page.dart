import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:money_manager/widgets/setting/setting.dart';
import 'package:money_manager/widgets/setting/avatar_card.dart';
import 'package:money_manager/widgets/setting/setting_tile.dart';
import 'package:money_manager/widgets/setting/support_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                  const AvatarCard(),
                  const SizedBox(height: 20),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings.length,
                      (index) => SettingTile(setting: settings[index]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings2.length,
                      (index) => SettingTile(setting: settings2[index]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SupportCard()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
