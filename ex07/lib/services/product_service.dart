import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  //  Ajuste aqui para seu IP:
  static const String baseUrlMobile = "http://127.0.0.1:3000";
  static const String baseUrlWeb = "http://127.0.0.1:3000";

  static String get url =>
      kIsWeb ? "$baseUrlWeb/produtos" : "$baseUrlMobile/produtos";

  // LISTAR PRODUTOS
  static Future<List<ProductModel>> listar() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar produtos: ${response.statusCode}");
    }
  }

  // CRIAR PRODUTO
  static Future<void> createProduct({
    required String nome,
    required String preco,
    required String descricao,
    String? imagemPath,
    Uint8List? imagemBytes,
    String? imagemNome,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['nome'] = nome;
    request.fields['preco'] = preco;
    request.fields['descricao'] = descricao;

    if (kIsWeb) {
      if (imagemBytes != null && imagemNome != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'imagem',
            imagemBytes,
            filename: imagemNome,
          ),
        );
      }
    } else {
      if (imagemPath != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagemPath),
        );
      }
    }

    final response = await request.send();
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Erro ao criar produto");
    }
  }

  // ATUALIZAR PRODUTO
  static Future<void> updateProduct({
    required int id,
    required String nome,
    required String preco,
    required String descricao,
    String? imagemPath,
    Uint8List? imagemBytes,
    String? imagemNome,
  }) async {
    var request = http.MultipartRequest('PUT', Uri.parse("$url/$id"));
    request.fields['nome'] = nome;
    request.fields['preco'] = preco;
    request.fields['descricao'] = descricao;

    if (kIsWeb) {
      if (imagemBytes != null && imagemNome != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'imagem',
            imagemBytes,
            filename: imagemNome,
          ),
        );
      }
    } else {
      if (imagemPath != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagemPath),
        );
      }
    }

    final response = await request.send();
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Erro ao atualizar produto");
    }
  }

  // DELETAR PRODUTO
  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse("$url/$id"));
    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar produto");
    }
  }
}
