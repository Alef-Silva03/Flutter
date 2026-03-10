// Importação do pacote principal do Flutter para interface Material Design
import 'package:flutter/material.dart';

void main() {
  // Ponto de entrada que inicia a execução do aplicativo Rock in Rio
  runApp(const RockInRio());
}

// Widget principal que configura as definições globais do aplicativo
class RockInRio extends StatelessWidget {
  const RockInRio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug do canto da tela
      title: 'Rock in Rio',
      // Definição do tema visual do aplicativo
      theme: ThemeData(
        brightness: Brightness.dark, // Define o modo escuro como padrão
        scaffoldBackgroundColor: const Color(0xFF121212), // Cor de fundo das telas
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, // Define o vermelho como cor base do esquema
          brightness: Brightness.dark,
        ), // ColorScheme.fromSeed
        appBarTheme: const AppBarTheme(
          centerTitle: true, // Centraliza o título em todas as AppBars
          backgroundColor: Colors.black, // Fundo preto para a barra superior
        ), // AppBarTheme
      ), // ThemeData
      home: const HomePage(), // Define a tela inicial do app
    ); // MaterialApp
  }
}

// Tela de listagem das atrações
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista dinâmica que gerencia quais atrações foram favoritadas pelo usuário
  List<String> favoritos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎸 Rock in Rio")),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(), // Efeito de rebote ao rolar a lista
        padding: const EdgeInsets.all(16),
        itemCount: listaAtracoes.length, // Quantidade de itens baseada na lista de dados
        itemBuilder: (context, index) {
          final atracao = listaAtracoes[index];
          final isFavorito = favoritos.contains(atracao.nome);

          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ), // RoundedRectangleBorder
            clipBehavior: Clip.antiAlias, // Garante que a imagem respeite o arredondamento do Card
            elevation: 6,
            child: InkWell(
              onTap: () {
                // Navega para a tela de detalhes ao clicar no card
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AtracaoPage(atracao: atracao),
                  ), // MaterialPageRoute
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animação de transição da imagem entre telas
                  Hero(
                    tag: atracao.nome,
                    child: Image.asset(
                      atracao.imagemUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover, // Preenche o espaço mantendo a proporção
                    ), // Image.asset
                  ), // Hero
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            atracao.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ), // TextStyle
                          ), // Text
                        ), // Expanded
                        IconButton(
                          icon: Icon(
                            isFavorito ? Icons.favorite : Icons.favorite_border,
                            color: isFavorito ? Colors.red : Colors.white,
                          ), // Icon
                          onPressed: () {
                            // Atualiza o estado da lista de favoritos
                            setState(() {
                              if (isFavorito) {
                                favoritos.remove(atracao.nome);
                              } else {
                                favoritos.add(atracao.nome);
                              }
                            });
                          },
                        ), // IconButton
                      ],
                    ), // Row
                  ), // Padding
                ],
              ), // Column
            ), // InkWell
          ); // Card
        },
      ), // ListView.builder
    ); // Scaffold
  }
}

// Tela de detalhes da atração selecionada
class AtracaoPage extends StatelessWidget {
  final Atracao atracao;

  const AtracaoPage({super.key, required this.atracao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero para completar a animação vinda da tela inicial
            Hero(
              tag: atracao.nome,
              child: Image.asset(
                atracao.imagemUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ), // Image.asset
            ), // Hero
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atracao.nome,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text
                  const SizedBox(height: 10),
                  Text(
                    "Dia ${atracao.dia}",
                    style: const TextStyle(fontSize: 18),
                  ), // Text
                  const SizedBox(height: 20),
                  // Lista de tags (chips) da atração
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: atracao.tags
                        .map(
                          (tag) => Chip(
                            label: Text('#$tag'),
                            backgroundColor: Colors.red.shade800,
                          ), // Chip
                        )
                        .toList(),
                  ), // Wrap
                  const SizedBox(height: 40),
                  // Botão para voltar à tela anterior
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ), // RoundedRectangleBorder
                      ), // ElevatedButton.styleFrom
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Voltar"),
                    ), // ElevatedButton.icon
                  ), // SizedBox
                  const SizedBox(height: 30),
                ],
              ), // Column
            ), // Padding
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}

// Classe que define o modelo de dados de uma atração
class Atracao {
  final String nome;
  final int dia;
  final List<String> tags;
  final String imagemUrl;

  const Atracao(this.nome, this.dia, this.tags, this.imagemUrl);
}

// Lista constante contendo os dados das atrações (Mock Data)
const listaAtracoes = [
  Atracao(
    "Iron Maiden",
    2,
    ["Espetáculo", "Fãs", "Novo Álbum"],
    "assets/imagem/iron.jpg",
  ),
  Atracao(
    "Alok",
    3,
    ["Influente", "Top", "Show"],
    "assets/imagem/alok.jpg",
  ),
  Atracao(
    "Justin Bieber",
    4,
    ["TopCharts", "Hits", "Pop"],
    "assets/imagem/justin.jpg",
  ),
  Atracao(
    "Green Day",
    9,
    ["Sucesso", "Reconhecimento", "Show"],
    "assets/imagem/green_day.jpg",
  ),
  Atracao(
    "Ivete Sangalo",
    10,
    ["Carreira", "Energia", "Brasil"],
    "assets/imagem/ivete.jpg",
  ),
];