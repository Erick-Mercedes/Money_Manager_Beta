import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Color de fondo de la página
        fontFamily: 'Roboto',
      ),
    );
  }
}

class FaqPage extends StatelessWidget {
  final List<FaqItem> faqItems = [
    FaqItem(
      title: '¿Qué se puede hacer aquí?',
      content:
          'Aquí puedes encontrar información sobre nuestros servicios y productos.',
    ),
    FaqItem(
      title: '¿Cómo puedo contactarnos?',
      content:
          'Puedes contactarnos a través de nuestro correo electrónico o teléfono.',
    ),
    FaqItem(
      title: '¿Cómo cambiar la foto de perfil?',
      content:
          'Para cambiar la foto de perfil, haga clic en la imagen de perfil actual y seleccione una nueva imagen de su galería.',
    ),
    FaqItem(
      title: '¿Cómo actualizar la dirección?',
      content:
          'Puede actualizar su dirección yendo a la sección de datos personales y haciendo clic en "Editar" junto a la dirección.',
    ),
    // Agrega más preguntas frecuentes aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas Frecuentes'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [preguntaAppbarColor2, preguntaAppbarColor],
            ),
          ),
        ),
      ),
      body: ListView(
        children: faqItems.map((faqItem) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaqItemWidget(faqItem: faqItem),
          );
        }).toList(),
      ),
    );
  }
}

class FaqItem {
  final String title;
  final String content;

  FaqItem({required this.title, required this.content});
}

class FaqItemWidget extends StatefulWidget {
  final FaqItem faqItem;

  FaqItemWidget({required this.faqItem});

  @override
  _FaqItemWidgetState createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.faqItem.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 30.0,
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.faqItem.content,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
        ],
      ),
    );
  }
}
