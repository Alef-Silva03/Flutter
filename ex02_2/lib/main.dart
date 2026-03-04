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
      home: CalcularMedia(),
    );
  }
}

class CalcularMedia extends StatefulWidget{
  const CalcularMedia({super.key});
  @override
  State<CalcularMedia> createState() => _AlunoMediaPageState();
}

class _AlunoMediaPageState extends State<CalcularMedia>{
  double nota1 = 0;
  double nota2 = 0;
  double nota3 = 0;
  double nota4 = 0;
  double media = 0;
  String resultado = "";
  
  final double mediaMinima = 7.0;

  final TextEditingController campo1 = TextEditingController();
  final TextEditingController campo2 = TextEditingController();
  final TextEditingController campo3 = TextEditingController();
  final TextEditingController campo4 = TextEditingController();

  void CalcularMedia(){
    setState(() {
      nota1 = double.parse(campo1.text);
      nota2 = double.parse(campo2.text);
      nota3 = double.parse(campo3.text);
      nota4 = double.parse(campo4.text);

      media = (nota1 + nota2 + nota3 + nota4)/4;

      if (media >= mediaMinima){
        resultado = "aprovado";
      }else{
        resultado = "reprovado";
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calcular Média"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Digite as 4 notas do Aluno",
              style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: campo1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nota 1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: campo2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nota 2",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: campo3,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nota 3",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: campo4,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nota 4",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(onPressed: CalcularMedia,
              child: const Text("Calcular Média"),
            ),
            const SizedBox(height: 30),
            
            Text(
              "media = ${media.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22), 
            ),
            
            const SizedBox(height: 10),

            Text(
              resultado,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}