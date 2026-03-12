import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartScreen extends StatelessWidget {
  final List<ProductModel> carrinho;

  const CartScreen({super.key, required this.carrinho});

  @override
  Widget build(BuildContext context) {
    double total = carrinho.fold(0, (sum, item) => sum + item.preco);
    return Scaffold(
      body: carrinho.isEmpty
          ? const Center(child: Text("Carrinho Vazio"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carrinho.length,
                    itemBuilder: (context, index) {
                      final item = carrinho[index];
                      return ListTile(
                        title: Text(item.nome),
                        subtitle: Text("R\$ ${item.preco}"),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Total R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
    );
  }
}
