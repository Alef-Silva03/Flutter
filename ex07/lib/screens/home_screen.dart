import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'orders_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String nome;

  const HomeScreen({super.key, required this.nome});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  List<ProductModel> produtos = [
    ProductModel(
      nome: "Maçã",
      preco: 5.50,
      descricao: "Maçã fresca e orgânica",
      imagem: "assets/imagem/maca.jpg",
    ),
    ProductModel(
      nome: "Banana",
      preco: 3.20,
      descricao: "Banana madura e doce",
      imagem: "assets/imagem/banana.jpg",
    ),
  ];

  List<ProductModel> carrinho = [];

  @override
  Widget build(BuildContext context) {
    final telas = [
      _paginaHome(),
      CartScreen(carrinho: carrinho),
      ProfileScreen(nome: widget.nome),
      const OrdersScreen(),
    ];

    return Scaffold(
      body: telas[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.blue,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.store), label: "Home"),
          BottomNavigationBarItem(
            label: "Carrinho",
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (carrinho.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        carrinho.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Pedidos",
          ),
        ],
      ),
    );
  }

  // ================= HOME PRINCIPAL =================

  Widget _paginaHome() {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Seja bem-vindo, ${widget.nome}!",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _atalhosRapidos(),
            const SizedBox(height: 10),
            _listaProdutos(),
          ],
        ),
      ),
    );
  }
  // ================= ATALHOS RÁPIDOS =================

  Widget _atalhosRapidos() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        children: [
          _botaoAtalho(
            icon: Icons.shopping_cart,
            label: "Carrinho",
            onTap: () => setState(() => _index = 1),
          ),
          _botaoAtalho(
            icon: Icons.person,
            label: "Perfil",
            onTap: () => setState(() => _index = 2),
          ),
          _botaoAtalho(
            icon: Icons.list_alt,
            label: "Pedidos",
            onTap: () => setState(() => _index = 3),
          ),
          _botaoAtalho(
            icon: Icons.store,
            label: "Produtos",
            onTap: () => setState(() => _index = 0),
          ),
        ],
      ),
    );
  }

  Widget _botaoAtalho({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ================= LISTA DE PRODUTOS =================

  Widget _listaProdutos() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        final produto = produtos[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(produto.imagem),
            title: Text(produto.nome),
            subtitle: Text("R\$ ${produto.preco.toStringAsFixed(2)}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(produto: produto),
                ),
              );

              if (result != null) {
                setState(() {
                  carrinho.add(produto);
                });
              }
            },
          ),
        );
      },
    );
  }
}
