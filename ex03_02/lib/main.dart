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
      home: ListaAlunoPage(),
    );
  }
}

class ListaAlunoPage extends StatefulWidget {
  const ListaAlunoPage({super.key});
  @override
  State<ListaAlunoPage> createState() => _ListaAlunoPageState();
}

class _ListaAlunoPageState extends State<ListaAlunoPage> {
  List<String> alunos = ['João', 'Maria', 'Pedro', 'Ana', 'Lucas'];
  String resultado = '';

  void mostrarAlunos() {
    String temp = '';

    for (String aluno in alunos) {
      temp += "Aluno: $aluno\n";
    }
    setState(() {
      resultado = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Alunos"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: mostrarAlunos,
              child: const Text("Mostrar Alunos"),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
