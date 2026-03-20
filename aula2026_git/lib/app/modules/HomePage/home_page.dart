// Importa os widgets do Material Design do Flutter
import 'package:aula2026_git/app/modules/Imc/imc.dart';
import 'package:aula2026_git/app/modules/TestesVisuais/testes_visuais.dart';
import 'package:flutter/material.dart';

// Importa a página de cadastro que será aberta ao clicar no botão
import '../CadastroModelo/Cadastro_Modelo.dart';

// Classe principal da tela HomePage
// StatefulWidget é usado quando a tela pode ter alterações de estado
class HomePage extends StatefulWidget {
  // Construtor da página
  // super.key ajuda o Flutter a identificar o widget na árvore
  const HomePage({super.key});

  // Cria o estado da página
  @override
  State<HomePage> createState() => HomePageState();
}

// Classe que controla o estado da HomePage
class HomePageState extends State<HomePage> {
  // Método responsável por construir a interface da tela
  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        // Título exibido na AppBar
        title: const Text(
          'Home Page',

          // Estilo do texto do título
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        // Cor de fundo da AppBar
        backgroundColor: Colors.blue,

        // Cor dos textos e ícones da AppBar
        foregroundColor: Colors.white,
      ),

      // Corpo da tela
      // Está chamando o método principal() que retorna o conteúdo
      body: principal(),
    );
  }

  // Método responsável por montar o conteúdo principal da tela
  Center principal() {
    // Center centraliza o conteúdo na tela
    return Center(
      // Column organiza os widgets em coluna (vertical)
      child: Column(
        // Alinha os elementos no centro vertical da tela
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Texto principal
          const Text(
            'Bem-vindo a Home Page!',

            // Estilo do texto
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Espaço entre o texto e o botão
          const SizedBox(height: 20),

          // Botão de exemplo
          ElevatedButton(
            // Função executada quando o botão é pressionado
            onPressed: () {
              // Navigator.push abre uma nova tela
              Navigator.push(
                // Contexto atual da aplicação
                context,

                // Define qual página será aberta
                MaterialPageRoute(
                  // builder cria a nova página
                  builder: (_) => CadastroModeloPage(),
                ),
              );
            },

            // Estilo do botão
            style: ElevatedButton.styleFrom(
              // Cor de fundo do botão
              backgroundColor: Colors.blue,

              // Cor do texto do botão
              foregroundColor: Colors.white,

              // Espaçamento interno do botão
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),

            // Texto exibido no botão
            child: const Text('Ir para Cadastro Modelo'),
          ),

          const SizedBox(height: 20),

          //chamando a tela de testes visuais
          ElevatedButton(
            // Função executada quando o botão é pressionado
            onPressed: () {
              // Navigator.push abre uma nova tela
              Navigator.push(
                // Contexto atual da aplicação
                context,

                // Define qual página será aberta
                MaterialPageRoute(
                  // builder cria a nova página
                  builder: (_) => TesteVisuaisPage(),
                ),
              );
            },

            // Estilo do botão
            style: ElevatedButton.styleFrom(
              // Cor de fundo do botão
              backgroundColor: Colors.blue,

              // Cor do texto do botão
              foregroundColor: Colors.white,

              // Espaçamento interno do botão
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),

            // Texto exibido no botão
            child: const Text('Testes Visuais'),
          ),

          const SizedBox(height: 20),

          //chamando a tela de testes visuais
          ElevatedButton(
            // Função executada quando o botão é pressionado
            onPressed: () {
              // Navigator.push abre uma nova tela
              Navigator.push(
                // Contexto atual da aplicação
                context,

                // Define qual página será aberta
                MaterialPageRoute(
                  // builder cria a nova página
                  builder: (_) => ImcPage(),
                ),
              );
            },

            // Estilo do botão
            style: ElevatedButton.styleFrom(
              // Cor de fundo do botão
              backgroundColor: Colors.blue,

              // Cor do texto do botão
              foregroundColor: Colors.white,

              // Espaçamento interno do botão
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),

            // Texto exibido no botão
            child: const Text('IMC'),
          ),
        ],
      ),
    );
  }
}


// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home Page')),
//       body: principal(),
//     );
//   }

//   principal() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             child: Text('Tela de Cadastro Modelo'),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => CadastroModeloPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }