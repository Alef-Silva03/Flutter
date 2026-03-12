import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String nome;

  const ProfileScreen({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 100),
          const SizedBox(height: 20),
          Text("Usuário: $nome", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
