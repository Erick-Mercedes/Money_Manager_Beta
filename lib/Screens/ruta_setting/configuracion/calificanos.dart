import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RatingPage(),
    );
  }
}

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating = 0;
  int _bestRating = 0;

  @override
  void initState() {
    super.initState();
    _loadBestRating();
  }

  void _loadBestRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bestRating = prefs.getInt('best_rating') ?? 0;
    });
  }

  void _saveBestRating(int rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('best_rating', rating);
  }

  void _handleRating(int rating) {
    setState(() {
      _rating = rating;
    });
    if (rating > _bestRating) {
      _saveBestRating(rating);
      setState(() {
        _bestRating = rating;
      });
    }
  }

  Color getStarColor(int starNumber) {
    if (_rating >= starNumber) {
      return starNumber == 1
          ? Colors.red
          : starNumber == 2
              ? Colors.orange
              : starNumber == 3
                  ? Colors.yellow
                  : starNumber == 4
                      ? Colors.blue
                      : Colors.green;
    } else {
      return Colors.grey[300]!; // Fondo blanco, bordes grises
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Calificanos',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child:
                Image.asset(stars), // Cambia esto por la ubicación de tu imagen
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Por favor, califica esta aplicación.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 1; i <= 5; i++) buildStar(i),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Mejor calificación',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.star_border_rounded,
                            color: getStarColor(_bestRating),
                            size: 40,
                          ),
                          Text(
                            '$_bestRating Estrella',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tu calificación. $_rating Estrella.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '¡Gracias por evaluar nuestra aplicacion.!',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget buildStar(int starRating) {
    return IconButton(
      icon: Icon(
        Icons.star_border_rounded,
        color: getStarColor(starRating),
        size: 40,
      ),
      onPressed: () {
        _handleRating(starRating);
      },
    );
  }
}
