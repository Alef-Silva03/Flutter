import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  UserModel? usuarioCadastrado;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  void fazerLogin() {
    if (usuarioCadastrado != null &&
        loginController.text == usuarioCadastrado!.login &&
        senhaController.text == usuarioCadastrado!.Senha) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(nome: usuarioCadastrado!.nome),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Inválido")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.lock, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              TextField(
                controller: loginController,
                decoration: const InputDecoration(
                  labelText: "Login",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fazerLogin,
                child: const Text("Entrar"),
              ),
              TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );

                  if (result != null) {
                    setState(() {
                      usuarioCadastrado = result;
                    });
                  }
                },
                child: const Text("Criar novo perfil"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
