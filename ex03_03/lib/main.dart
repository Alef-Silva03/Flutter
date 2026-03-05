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
      home: ContadorPage(),
    );
  }
}

class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  final TextEditingController numeroController = TextEditingController();
  String resultado = '';

  void Contar() {
    int numero = int.tryParse(numeroController.text) ?? 0;
    int contador = 1;
    String temp = "";

    while (contador <= numero) {
      temp += "$contador\n";
      contador++;
    }
    setState(() {
      resultado = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador com While"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),  
        child: Column(
          children: [
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite um número",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: Contar, child: const Text("Contar")),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
