import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  bool darkMode = false;
  int indiceCor = 0;
  Color corFundo = Colors.yellow.shade100;
  void mudarCor() {
    setState(() {
      indiceCor++;
      switch (indiceCor) {
        case 1:
          corFundo = Colors.green.shade100;
          break;
        case 2:
          corFundo = Colors.purple.shade100;
          break;
        case 3:
          corFundo = Colors.blue.shade100;
          break;
        case 4:
          corFundo = Colors.pink.shade100;
          break;
        default:
          indiceCor = 0;
          corFundo = Colors.yellow.shade100;
      }
    });
  }

  void alternarDark() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: corFundo,
        primarySwatch: Colors.yellow,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: TelaIMC(mudarCor: mudarCor, alternarDark: alternarDark),
    );
  }
}

class TelaIMC extends StatefulWidget {
  final Function mudarCor;
  final Function alternarDark;
  const TelaIMC({
    super.key,
    required this.mudarCor,
    required this.alternarDark,
  });
  State<TelaIMC> createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();

  String resultado = '';
  double imc = 0;

  Color corResultado = Colors.red;
  IconData iconeSaude = Icons.favorite;

  void calcularIMC() {
    if (nomeController.text.isEmpty ||
        idadeController.text.isEmpty ||
        alturaController.text.isEmpty ||
        pesoController.text.isEmpty) {
      setState(() {
        resultado = "Preencha todos os campos!";
      });
      return;
    }
    double altura = double.parse(alturaController.text.replaceAll(",", "."));
    double peso = double.parse(pesoController.text.replaceAll(",", "."));

    imc = peso / (altura * altura);

    String classificacao = "";

    int idade = int.parse(idadeController.text);

    if (imc < 18.5) {
      classificacao = "Abaixo do peso";
      corResultado = Colors.orange;
      iconeSaude = Icons.sentiment_dissatisfied;
    } else if (imc < 25) {
      classificacao = "Peso normal";
      corResultado = Colors.green;
      iconeSaude = Icons.sentiment_satisfied;
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
      corResultado = Colors.orange;
      iconeSaude = Icons.warning;
    } else if (imc < 35) {
      classificacao = "Obesidade grau 1";
      corResultado = Colors.red;
      iconeSaude = Icons.health_and_safety;
    } else if (imc < 40) {
      classificacao = "Obesidade grau 2";
      corResultado = Colors.red;
      iconeSaude = Icons.error;
    } else {
      classificacao = "Obesidade grau 3";
      corResultado = Colors.red;
      iconeSaude = Icons.dangerous;
    }
    setState(() {
      resultado =
          "${nomeController.text}\n $idade anos\n"
          "Seu IMC é: ${imc.toStringAsFixed(2).replaceAll(".", ",")}\n"
          "Classificação: $classificacao";
    });
  }

  void limparCampos() {
    nomeController.clear();
    idadeController.clear();
    alturaController.clear();
    pesoController.clear();
    resultado = "";
    imc = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
      ),

      //body: SingleChildScrollView(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("imagem/saude.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Idade",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (ex: 1,75)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (ex: 70,5)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  ElevatedButton.icon(
                    onPressed: calcularIMC,
                    icon: const Icon(Icons.calculate),
                    label: const Text("Calcular"),
                  ),

                  ElevatedButton.icon(
                    onPressed: limparCampos,
                    icon: const Icon(Icons.cleaning_services),
                    label: const Text("Limpar"),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  ElevatedButton.icon(
                    onPressed: () => widget.mudarCor(),
                    icon: const Icon(Icons.palette),
                    label: const Text("Cor"),
                  ),

                  ElevatedButton.icon(
                    onPressed: () => widget.alternarDark(),
                    icon: const Icon(Icons.dark_mode),
                    label: const Text("Dark"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 8,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(25),

                  child: Column(
                    children: [
                      Icon(iconeSaude, size: 70, color: corResultado),

                      const SizedBox(height: 10),

                      Text(
                        resultado,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: corResultado,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: imc == 0 ? 0 : imc / 40,
                          minHeight: 20,
                          backgroundColor: Colors.grey[300],
                          color: corResultado,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
