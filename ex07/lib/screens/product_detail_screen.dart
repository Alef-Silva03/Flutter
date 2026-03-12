import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel produto;

  const ProductDetailScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produto.nome)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(produto.imagem, height: 200),
            const SizedBox(height: 20),
            Text(produto.descricao),
            const SizedBox(height: 20),
            Text(
              "R\$ ${produto.preco.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Adicionar ao Carrinho"),
            ),
          ],
        ),
      ),
    );
  }
}
