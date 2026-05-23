// lib/app/modules/contador/contador_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contador_controller.dart';

class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  final _valorController = TextEditingController();

  // ✅ USE Get.find() para encontrar a instância que já existe
  final _controller = Get.find<ContadorController>();

  void _limparCampos() {
    _valorController.clear();
  }

  void _incrementarContador() {
    _controller.incrementar();
  }

  void _decrementarContador() {
    _controller.decrementar();
  }

  void _resetarContador() {
    _controller.resetar();
    _limparCampos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador com GetX'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Exibição do contador
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Valor Atual',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Text(
                              '${_controller.contador.value}',
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botões de controle do contador
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _decrementarContador,
                    icon: const Icon(Icons.remove),
                    label: const Text('Decrementar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _resetarContador,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Resetar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _incrementarContador,
                    icon: const Icon(Icons.add),
                    label: const Text('Incrementar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }
}
