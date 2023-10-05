import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSelectionPage extends StatefulWidget {
  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apariencia'),
        backgroundColor: _selectedColor,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: _selectedColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selecciona un color:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 20,
                children: _availableColors
                    .asMap()
                    .entries
                    .map(
                      (entry) => ColorButton(
                        color: entry.value,
                        onPressed: () {
                          _saveSelectedColor(entry.key);
                        },
                        isSelected: _selectedColor == entry.value,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final bool isSelected;

  ColorButton({
    required this.color,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: isSelected ? 10 : 0,
        padding: EdgeInsets.all(16),
      ),
      child: Icon(
        Icons.brush_outlined, // Cambia 'Icons.check' al icono que desees
        color: isSelected ? Colors.black : Colors.transparent,
      ),
      /*child: Text(
        isSelected ? 'Select' : '',
        style: TextStyle(color: Colors.black),
      ),*/
    );
  }
}
