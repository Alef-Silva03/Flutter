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
      home: TabuadaPage(),
    );
  }
}

class TabuadaPage extends StatefulWidget {
  const TabuadaPage({super.key});
  @override
  State<TabuadaPage> createState() => _TabuadaPageState();
}

class _TabuadaPageState extends State<TabuadaPage> {
  final TextEditingController numeroController = TextEditingController();
  String resultado = "";
  void calcularTabuada() {
    int numero = int.tryParse(numeroController.text) ?? 0;
    String temp = "";

    for (int i = 0; i <= 10; i++) {
      int multiplicacao = numero * i;
      temp += "$numero x $i = $multiplicacao\n";
    }
    setState(() {
      //teve modificação na tela
      resultado = temp;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabuada de Multiplicar com FOR"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite um numero",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularTabuada,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
