import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String _baseUrl =
      'https://crudcrud.com/api/ea481eb82f3b4b4da5aba1836f4d309b/aula';

  final url = Uri.parse(_baseUrl);

  Future<List<Map<String, dynamic>>> listarClientes() async {
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final dados = json.decode(resposta.body);

      return List<Map<String, dynamic>>.from(dados);
    } else {
      throw Exception('Erro ao listar clientes');
    }
  }

  Future<String> inserirClientes(Map<String, dynamic> cliente) async {
    final resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente),
    );

    if (resposta.statusCode == 201) {
      final dados = json.decode(resposta.body);

      return dados['_id'];
    } else {
      throw Exception('Erro ao inserir clientes');
    }
  }

  Future<void> atualizarClientes(
    String id,
    Map<String, dynamic> cliente,
  ) async {
    final resposta = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao atualizar clientes: $resposta.statusCode');
    }
  }

  Future<void> deletarClientes(String id) async {
    final resposta = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao deletar clientes: $resposta.statusCode');
    }
  }
}
