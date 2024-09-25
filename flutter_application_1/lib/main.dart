import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaCalculadora(),
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  @override
  _TelaCalculadoraState createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  double x = 0, y = 0, resultado = 0;

  void _navegarParaPreencherValores(String valorParaDefinir) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreencherValores(valorParaDefinir),
      ),
    );

    setState(() {
      if (valorParaDefinir == 'x') {
        x = resultado ?? 0;
      } else if (valorParaDefinir == 'y') {
        y = resultado ?? 0;
      }
    });
  }

  void _calcular() {
    setState(() {
      resultado = x + y;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('X: $x'),
          Text('Y: $y'),
          ElevatedButton(
            onPressed: () => _navegarParaPreencherValores('x'),
            child: Text('Informar X'),
          ),
          ElevatedButton(
            onPressed: () => _navegarParaPreencherValores('y'),
            child: Text('Informar Y'),
          ),
          ElevatedButton(
            onPressed: _calcular,
            child: Text('Calcular'),
          ),
          Text('Resultado: $resultado'),
        ],
      ),
    );
  }
}

class PreencherValores extends StatelessWidget {
  final String valorParaDefinir;
  final TextEditingController _controller = TextEditingController();

  PreencherValores(this.valorParaDefinir);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preencher Valores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Digite o valor para $valorParaDefinir:'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final valor = double.tryParse(_controller.text);
                Navigator.pop(context, valor);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
