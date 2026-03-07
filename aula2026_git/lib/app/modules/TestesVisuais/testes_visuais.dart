// Importa a biblioteca principal do Flutter com os widgets de interface
import 'package:flutter/material.dart';

// Classe da página CadastroModelo
// StatefulWidget é usado quando a tela pode mudar de estado
class TesteVisuaisPage extends StatefulWidget {
  // Construtor da página
  const TesteVisuaisPage({super.key});

  // Cria o estado da página
  @override
  State<TesteVisuaisPage> createState() => TesteVisuaisPageState();
}

// Classe que controla o estado da página
class TesteVisuaisPageState extends State<TesteVisuaisPage> {
  // Variável que guarda qual item do BottomNavigationBar está selecionado
  int _currentIndex = 0;

  // Método responsável por construir a interface da tela
  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela
    return Scaffold(
      // Barra superior da aplicação
      appBar: AppBar(
        // Título exibido na AppBar
        title: const Text(
          'Testes Visuais',

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
          IconButton(
            // Ícone de busca
            icon: Icon(Icons.search),

            // Ação ao clicar
            onPressed: () {
              debugPrint('Pesquisar pressionado');
            },
          ),
        ],
      ),

      // Corpo principal da tela
      body: principal(),

      // Botão flutuante no canto inferior direito
      floatingActionButton: FloatingActionButton(
        // Ícone exibido no botão
        child: Icon(Icons.add),

        // Ação ao clicar
        onPressed: () {
          debugPrint('Botão de ação pressionado');
        },
      ),

      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        // Itens da barra inferior
        items: const [
          // Primeiro item
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          // Segundo item
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),

          // Terceiro item
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],

        // Item atualmente selecionado
        currentIndex: _currentIndex.toString() != '' ? _currentIndex : 0,

        // Cor do item selecionado
        selectedItemColor: Colors.blue,

        // Função executada ao clicar em um item
        onTap: (index) {
          // Atualiza o estado da tela
          setState(() {
            // Atualiza o índice selecionado
            _currentIndex = index;
          });

          // Mostra no console qual ícone foi clicado
          debugPrint('Ícone $index pressionado');
        },
      ),
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
          Container(
            width: 300,
            height: 200,
            // margin: EdgeInsets.only(bottom: 200),
            // padding: EdgeInsets.only(left: 20, top: 100),
            color: Colors.amber,
            child: Text('Teste de Container'),
          ),
          SizedBox(height: 20),

          Text(
            'Teste de Texto',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 40,
              decoration: TextDecoration.underline,
            ),
          ),

          SizedBox(height: 20),

          Image.asset(
            'assets/logomarca/unesc2.png',
            //   width: 300,
            //   height: 300,
            //   fit: BoxFit.fill,
          ),

          SizedBox(height: 20),

          Image.network(
            'https://nxboats.com.br/wp-content/uploads/2023/11/marcas-de-carros-de-luxo-lamborghini.jpg',
            width: 200,
          ),
        ],
      ),
    );
  }
}
