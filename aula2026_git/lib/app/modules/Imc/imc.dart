// Importa a biblioteca principal do Flutter com os widgets de interface
import 'package:flutter/material.dart';

// Classe da página CadastroModelo
// StatefulWidget é usado quando a tela pode mudar de estado
class ImcPage extends StatefulWidget {
  // Construtor da página
  const ImcPage({super.key});

  // Cria o estado da página
  @override
  State<ImcPage> createState() => CadastroModeloPageState();
}

// Classe que controla o estado da página
class CadastroModeloPageState extends State<ImcPage> {
  // Variável que guarda qual item do BottomNavigationBar está selecionado
  int _currentIndex = 0;

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String resultado = 'Preencha os valores';
  String frase = '';
  int imagem = 1;

  // Método responsável por construir a interface da tela
  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela
    return Scaffold(
      // Barra superior da aplicação
      appBar: AppBar(
        // Título exibido na AppBar
        title: const Text(
          'Calculo IMC',

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
      child: SingleChildScrollView(
        child: Column(
          // Alinha os elementos no centro vertical
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const SizedBox(height: 20),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso",
                labelStyle: TextStyle(fontSize: 28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura",
                labelStyle: TextStyle(fontSize: 28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botão de exemplo
            ElevatedButton(
              // Ação ao clicar
              onPressed: () {
                calcularIMC();
                //   debugPrint('Calcular IMC');
              },

              // Estilo do botão
              style: ElevatedButton.styleFrom(
                // Cor de fundo
                backgroundColor: Colors.blue,

                // Cor do texto
                foregroundColor: Colors.white,

                // Espaçamento interno
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),

              // Texto do botão
              child: const Text('Calcular IMC'),
            ),

            const SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              frase,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/imc/$imagem.png'),
          ],
        ),
      ),
    );
  }

  void calcularIMC() {
    final pesoText = pesoController.text.replaceAll(',', '.');
    final alturaText = alturaController.text.replaceAll(',', '.');

    final peso = double.tryParse(pesoText);
    final altura = double.tryParse(alturaText);

    if (peso == null || altura == null) {
      setState(() {
        resultado = 'Preecha valores válidos';
      });
      return;
    }

    final imc = peso / (altura * altura);

    if (imc < 20.7) {
      frase = 'Abaixo do peso';
      imagem = 1;
    } else if (imc <= 26.4) {
      frase = 'No peso normal';
      imagem = 2;
    } else if (imc <= 27.8) {
      frase = 'Marginalmente acima do peso';
      imagem = 3;
    } else if (imc <= 31.1) {
      frase = 'Acima do peso ideal';
      imagem = 4;
    } else {
      frase = 'Obeso';
      imagem = 6;
    }

    setState(() {
      resultado = 'IMC: ${imc.toStringAsFixed(2)}';
    });
  }
}
