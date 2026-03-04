import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});
  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  double n1 = 0;
  double n2 = 0;
  double resultado = 0;

  final TextEditingController campo1 = TextEditingController();
  final TextEditingController campo2 = TextEditingController();

  void somar() {
    setState(() {
      n1 = double.parse(campo1.text);
      n2 = double.parse(campo2.text);
      resultado = n1 + n2;
    });
  }

  void subtrair() {
    setState(() {
      n1 = double.parse(campo1.text);
      n2 = double.parse(campo2.text);
      resultado = n1 - n2;
    });
  }

  void multiplicar() {
    setState(() {
      n1 = double.parse(campo1.text);
      n2 = double.parse(campo2.text);
      resultado = n1 * n2;
    });
  }

  void dividir() {
    setState(() {
      n1 = double.parse(campo1.text);
      n2 = double.parse(campo2.text);
      resultado = n1 / n2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora do Alef em Flutter"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: campo1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite o primeiro número",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: campo2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite o segundo número",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: somar,child: const Text("+")),
                ElevatedButton(onPressed: subtrair,child: const Text("-")),
                ElevatedButton(onPressed: multiplicar,child: const Text("X")),
                ElevatedButton(onPressed: dividir,child: const Text("/")),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "resultado: $resultado",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    ) ;
  }
}