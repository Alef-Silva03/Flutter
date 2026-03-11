class UserModel{
  String login;
  String Senha;
  String nome;
  String cpf;
  String email;
  String dataNascimento;
  String? foto; // espera um parâmetro
  
  UserModel({
    required this.login,
    required this.Senha,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.dataNascimento,
    this.foto,
  });
}
