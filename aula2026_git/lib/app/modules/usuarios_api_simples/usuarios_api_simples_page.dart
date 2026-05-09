import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosApiSimplesPage extends StatefulWidget {
  const UsuariosApiSimplesPage({super.key});

  @override
  State<UsuariosApiSimplesPage> createState() => UsuariosApiSimplesPageState();
}

class UsuariosApiSimplesPageState extends State<UsuariosApiSimplesPage> {
  List usuarios = [];

  Future<void> buscarUsuarios() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final resposta = await http.get(url);
    debugPrint(resposta.body);
  }

  // Método responsável por construir a interface da tela
  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela
    return Scaffold(
      // Barra superior da aplicação
      appBar: AppBar(
        // Título exibido na AppBar
        title: const Text(
          'Usuários API Simples',
          // Estilo do texto
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        // Cor de fundo da AppBar
        backgroundColor: Colors.blue,

        // Cor dos ícones e textos da AppBar
        foregroundColor: Colors.white,

        // Ícone à esquerda da AppBar
        leading: IconButton(
          // Ícone de menu
          icon: Icon(Icons.menu),

          // Ação ao clicar
          onPressed: () {
            // Imprime mensagem no console
            debugPrint('Menu pressionado');
          },
        ),
      ),

      // Corpo principal da tela
      body: principal(),
    );
  }

  // Método que cria o conteúdo principal da tela
  Center principal() {
    // Centraliza o conteúdo
    return Center(
      // Column organiza os elementos em coluna
      child: Column(
        // Alinha os elementos no centro vertical
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Texto principal da tela
          const Text(
            'Dados da Api',

            // Estilo do texto
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Espaço entre o texto e o botão
          const SizedBox(height: 20),

          // Botão de exemplo
          ElevatedButton(
            // Ação ao clicar
            onPressed: () {
              buscarUsuarios();
            },

            // Estilo do botão
            style: ElevatedButton.styleFrom(
              // Cor de fundo
              backgroundColor: Colors.blue,

              // Cor do texto
              foregroundColor: Colors.white,

              // Espaçamento interno
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),

            // Texto do botão
            child: const Text('Clique aqui'),
          ),
        ],
      ),
    );
  }
}
