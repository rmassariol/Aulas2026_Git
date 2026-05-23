// lib/app/modules/contador/contador_controller.dart
import 'package:get/get.dart';

class ContadorController extends GetxController {
  // Variável observável
  var contador = 0.obs;

  // Método para incrementar
  void incrementar() {
    contador.value++;
  }

  // Método para decrementar
  void decrementar() {
    if (contador.value > 0) {
      contador.value--;
    }
  }

  // Método para resetar - CORRIGIDO
  void resetar() {
    contador.value = 0; // Isso deve funcionar
    //  print('Resetado para: ${contador.value}'); // Para debug
  }

  // Método para definir um valor específico
  void setValor(int valor) {
    if (valor >= 0) {
      contador.value = valor;
    }
  }
}
