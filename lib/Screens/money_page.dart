import 'package:flutter/material.dart';
import 'package:money_manager/widgets/money/steaming.dart';
import 'package:money_manager/widgets/setting/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Divisa());
}

class Divisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraDivisaPage(),
    );
  }
}

class CalculadoraDivisaPage extends StatefulWidget {
  @override
  _CalculadoraDivisaPageState createState() => _CalculadoraDivisaPageState();
}

class _CalculadoraDivisaPageState extends State<CalculadoraDivisaPage> {
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
  final List jobsForYou = [
    //[ companyname, jobTitle, logoImagePath, hourlyRate]
    ['Amazon Prime', 'Amazon Prime', 'images/p128.png', 250.00],
    ['Apple TV+', 'Apple TV+', 'images/ap128.png', 6.99],
    ['Disney+', 'Disney+ / Star+', 'images/d128.png', 14.99],
    ['HBO Max', 'HBO Max', 'images/h128.png', 349.00],
    ['Netflix', 'Netflix', 'images/n128.png', 10.99],
    ['Spotify', 'Spotify', 'images/s128.png', 5.99],
    ['Youtube', 'YT Premium', 'images/y128.png', 10.99],
  ];

  final Map<String, double> divisas = {
    'USD': 1.0,
    'EUR': 0.85,
    'DOP': 56.0, // República Dominicana Peso (DOP)
    'MXN': 20.0, // México Peso (MXN)
    'COP': 3800.0, // Colombia Peso (COP)
  };

  String selectedDivisa = 'USD';
  TextEditingController inputController = TextEditingController();
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _selectedColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Calculadora de divisas',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: selectedDivisa,
                            items: divisas.keys.map((String divisa) {
                              return DropdownMenuItem<String>(
                                value: divisa,
                                child: Text(divisa),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedDivisa = newValue;
                                  calcularResultado();
                                });
                              }
                            },
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: TextField(
                              controller: inputController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Monto en ${selectedDivisa}',
                              ),
                              onChanged: (text) {
                                calcularResultado();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'USD = $resultado ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'El resultado de la divisa sera en Dolar USD',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Streaming
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Streaming',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 160,
                child: ListView.builder(
                  itemCount: jobsForYou.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return JobCard(
                      companyName: jobsForYou[index][0],
                      jobTitle: jobsForYou[index][1],
                      logoImagePath: jobsForYou[index][2],
                      hourlyRate: jobsForYou[index][3],
                    );
                  },
                ),
              ),
              //streaming
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DivisaTable(divisas: divisas),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcularResultado() {
    double monto = double.tryParse(inputController.text) ?? 0.0;
    double tasa = divisas[selectedDivisa] ?? 1.0;
    double resultadoCalculado =
        monto / tasa; // División en lugar de multiplicación
    setState(() {
      resultado = resultadoCalculado.toStringAsFixed(2);
    });
  }
}

class DivisaTable extends StatelessWidget {
  final Map<String, double> divisas;

  DivisaTable({required this.divisas});

  final Map<String, String> paises = {
    'USD': 'Estados Unidos',
    'EUR': 'Unión Europea',
    'DOP': 'República Dominicana',
    'MXN': 'México',
    'COP': 'Colombia',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              'Divisa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'País',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Valor',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: divisas.entries.map((entry) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(entry.key)),
              DataCell(Text(paises[entry.key] ?? '')),
              DataCell(Text(entry.value.toStringAsFixed(2))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
