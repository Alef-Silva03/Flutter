// Importação do pacote material, fundamental para componentes de interface Flutter
import 'package:flutter/material.dart';

// Função principal que inicia a execução do aplicativo
void main() {
  // Executa o widget inicial do app
  runApp(const MyApp());
}

// Widget principal que configura o MaterialApp
class MyApp extends StatelessWidget {
  // Construtor constante com passagem de chave para a classe pai
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura base do aplicativo Android/Material Design
    return const MaterialApp(
      // Remove a etiqueta de "debug" do canto superior direito da tela
      debugShowCheckedModeBanner: false,
      // Define a página inicial do aplicativo como o ContadorPessoasPage
      home: ContadorPessoasPage(),
    ); // MaterialApp
  }
}

// Definição da página do Contador de Pessoas como um StatefulWidget
// Isso permite que a página mude de estado (ex: incrementar números)
class ContadorPessoasPage extends StatefulWidget {
  // Construtor constante da página
  const ContadorPessoasPage({super.key});

  @override
  // Cria o estado interno associado a este widget
  State<ContadorPessoasPage> createState() => _ContadorPessoasPageState();
}

class _ContadorPessoasPageState extends State<ContadorPessoasPage> {
  // Variável inteira privada para armazenar a contagem atual de pessoas
  int _pessoas = 0;
  // Variável privada final que define o limite máximo permitido
  final int _limite = 10; // Limite máximo

  // Função privada para adicionar uma pessoa à contagem
  void _adicionarPessoa() {
    // O setState notifica o Flutter que o estado mudou e a interface precisa ser reconstruída
    setState(() {
      // Verifica se a contagem atual é menor que o limite antes de incrementar
      if (_pessoas < _limite) {
        _pessoas++; // Incrementa a contagem
      }
    });
  }

  // Função privada para remover uma pessoa da contagem
  void _removerPessoa() {
    // O setState notifica o Flutter que o estado mudou e a interface precisa ser reconstruída
    setState(() {
      // Verifica se a contagem é maior que zero para evitar números negativos
      if (_pessoas > 0) {
        _pessoas--; // Decrementa a contagem
      }
    });
  }

  @override
  // Método responsável por construir a interface visual da página
  Widget build(BuildContext context) {
    // Variável booleana que verifica se a capacidade máxima foi atingida ou ultrapassada
    bool lotado = _pessoas >= _limite;

    // O Scaffold fornece a estrutura básica visual (AppBar, Body, etc)
    return Scaffold(
      // Define a cor de fundo com um tom de azul bem claro
      backgroundColor: Colors.blue[50],
      // Barra superior do aplicativo
      appBar: AppBar(
        // Título centralizado na barra
        title: const Text("Controle de Pessoas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ), // AppBar
      // Corpo do aplicativo, centralizando o conteúdo
      body: Center(
        // Organiza os elementos em uma coluna vertical
        child: Column(
          // Alinha os filhos da coluna no centro verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone de pessoas estilizado
            const Icon(Icons.people, size: 80, color: Colors.blue), // Icon
            // Espaçamento vertical de 20 pixels
            const SizedBox(height: 20),
            const Text(
              "Quantidade de Pessoas:",
              style: TextStyle(fontSize: 20),
            ), // Text
            // Pequeno espaçamento entre os textos
            const SizedBox(height: 10),
            // Exibição do valor da contagem
            Text(
              "$_pessoas",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                // Muda para vermelho se estiver lotado, caso contrário permanece azul
                color: lotado ? Colors.red : Colors.blue,
              ), // TextStyle
            ), // Text
            // Espaçamento antes dos botões (que provavelmente virão na próxima imagem)
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // Cor de fundo dinâmica: vermelho claro se lotado, azul claro se disponível
                color: lotado ? Colors.red[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ), // BoxDecoration
              child: Text(
                // Lógica de texto ternária aninhada para exibir o status correto
                lotado
                    ? "Local LOTADO!"
                    : _pessoas == 0
                    ? "Local vazio"
                    : "Há $_pessoas pessoas no local",
                style: TextStyle(
                  fontSize: 18,
                  // Texto em vermelho se lotado, preto se disponível
                  color: lotado ? Colors.red : Colors.black,
                ), // TextStyle
              ), // Text
            ), // Container
            // Espaçamento antes dos botões de ação
            const SizedBox(height: 30),
            // Organiza os botões horizontalmente
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão para remover pessoas
                ElevatedButton(
                  onPressed: _removerPessoa,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ), // styleFrom
                  child: const Text("Remover"),
                ), // ElevatedButton
                // Espaçamento horizontal entre os botões
                const SizedBox(width: 20),

                // Botão para adicionar pessoas
                ElevatedButton(
                  // Desabilita o botão (null) se o local estiver lotado
                  onPressed: lotado ? null : _adicionarPessoa,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ), // styleFrom
                  child: const Text("Adicionar"),
                ), // ElevatedButton
              ],
            ), // Row
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
