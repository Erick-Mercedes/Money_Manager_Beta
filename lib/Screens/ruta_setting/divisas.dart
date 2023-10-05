import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Calculadora de Divisa',
          style: TextStyle(color: Colors.black),
        ),
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Implementa la lógica para regresar a la página anterior
          },
        ),*/
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DivisaTable(divisas: divisas),
            ),
          ],
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
