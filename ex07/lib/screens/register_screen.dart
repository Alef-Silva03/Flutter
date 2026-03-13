import 'package:flutter/material.dart';
import '../models/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // importa arquivos externos

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final login = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();
  final nome = TextEditingController();
  final cpf = TextEditingController();
  final email = TextEditingController();
  final data = TextEditingController();

  File? imagem;

  Future<void> selecionarImagem() async {
    final picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      setState(() {
        imagem = File(foto.path);
      });
    }
  }

  void cadastrar() {
    if (formKey.currentState!.validate()) {
      if (senha.text != confirmarSenha.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Senhas não conferem")));
        return;
      }
      final usuario = UserModel(
        login: login.text,
        senha: senha.text,
        nome: nome.text,
        cpf: cpf.text,
        email: email.text,
        dataNascimento: data.text,
        foto: imagem?.path,
      );
      Navigator.pop(context, usuario);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: selecionarImagem,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imagem != null ? FileImage(imagem!) : null,
                  child: imagem == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              campo(login, "Login", Icons.person),
              campo(senha, "Senha", Icons.lock, true),
              campo(confirmarSenha, "Confirmar Senha", Icons.lock, true),
              campo(nome, "Nome", Icons.badge),
              campo(cpf, "CPF", Icons.credit_card),
              campo(email, "Email", Icons.email),
              campo(data, "Data de Nascimento", Icons.calendar_today),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: cadastrar,
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
   Widget campo(
    TextEditingController controller,
    String label,
    IconData icon, [
    bool senha = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: senha,
        // Validação simples: não permite campo vazio
        validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ), // InputDecoration
      ), // TextFormField
    ); // Padding
  }
}

