// Importa a biblioteca principal do Flutter que contém os widgets do Material Design
import 'package:flutter/material.dart';

// Importa a página inicial do aplicativo localizada na pasta app/modules/HomePage
import 'app/modules/HomePage/home_page.dart';

// Função principal do programa (ponto de entrada da aplicação)
void main() {
  // Executa o aplicativo iniciando pelo widget MyApp
  runApp(const MyApp());
}

// Classe principal da aplicação
// StatelessWidget indica que este widget não possui estado mutável
class MyApp extends StatelessWidget {
  // Construtor da classe MyApp
  // super.key permite que o Flutter identifique este widget na árvore de widgets
  const MyApp({super.key});

  // This widget is the root of your application.
  // Este método constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget base para aplicativos que utilizam Material Design
    return MaterialApp(
      // Remove o banner vermelho de DEBUG exibido no canto superior da tela
      debugShowCheckedModeBanner: false,

      // Define o título do aplicativo
      // Esse título pode aparecer em gerenciadores de tarefas do sistema
      title: 'Flutter Demo',

      // Define o tema visual do aplicativo
      theme: ThemeData(
        // Cria um esquema de cores automático baseado em uma cor principal
        // O Flutter gera variações dessa cor para o tema do app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // Define qual será a primeira tela aberta quando o aplicativo iniciar
      home: HomePage(),
    );
  }
}
