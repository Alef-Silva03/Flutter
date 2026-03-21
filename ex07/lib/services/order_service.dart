import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class OrderService {
  static String get baseUrl => "http://127.0.0.1:3000";
  static String get url => "$baseUrl/pedidos";

  // criar pedidos
  static Future<bool> criarPedido(
    int usuarioId,
    List<CartModel> carrinho,
    double total,
  ) async {
    final itens = carrinho
        .map(
          (p) => {
            "produto_id": p.id,
            "nome": p.nome,
            "imagem": p.imagem,
            "quantidade": p.quantidade,
            "preco": p.preco,
          },
        )
        .toList();

    final body = {"usuario_id": usuarioId, "total": total, "itens": itens};

    print("ENVIANDO PARA API:");
    print(jsonEncode(body));

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
  }
// listar pedidos
  static Future<List<dynamic>> listarPedidos(int usuarioId) async {
    final response = await http.get(Uri.parse("$url/$usuarioId"));

    print("CHAMANDO: $url/$usuarioId");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro pedidos");
    }
  }
// itens do pedido
  static Future<List<dynamic>> listarItensPedido(int pedidoId) async {
    final response = await http.get(Uri.parse("$url/itens/$pedidoId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro itens");
    }
  }

  static Future<void> atualizarStatus(int id, String status) async{
    final response = await http.put(
      Uri.parse("$url/$id"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"status":status}),
    );
    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if(response.statusCode != 200){
      print("Erro Completo: ${response.body}");
      throw Exception("Erro: ${response.statusCode}");
    }
  }

  static Future<void> deletarPedido(int id) async{
    final response = await http.delete(Uri.parse("$url/$id"));

    if(response.statusCode !=200){
      throw Exception("Erro ao excluir pedido");
    }
  }
}