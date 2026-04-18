// Importa a biblioteca principal do Flutter com os widgets de interface
import 'package:aula2026_git/app/data/services/database_helper.dart';
import 'package:flutter/material.dart';

// Classe da página CadastroModelo
// StatefulWidget é usado quando a tela pode mudar de estado
class CadClientePage extends StatefulWidget {
  // Construtor da página
  const CadClientePage({super.key});

  // Cria o estado da página
  @override
  State<CadClientePage> createState() => CadClientePageState();
}

// Classe que controla o estado da página
class CadClientePageState extends State<CadClientePage> {
  final _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _clientes = [];

  Future<void> _carregarClientes() async {
    final lista = await _databaseHelper.listarClientes();
    setState(() {
      _clientes = lista;
    });
    debugPrint('Clientes carregados: $_clientes');
  }

  @override
  initState() {
    super.initState();
    _carregarClientes();
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
          'Cadastro de Clientes',

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

        // Ícones do lado direito da AppBar
        actions: [
          // Botão de voltar
          IconButton(
            // Ícone de seta para trás
            icon: Icon(Icons.arrow_back),

            // Ao clicar volta para a tela anterior
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          // Botão de pesquisa
        ],
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
            'Bem-vindo!',

            // Estilo do texto
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Espaço entre o texto e o botão
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
