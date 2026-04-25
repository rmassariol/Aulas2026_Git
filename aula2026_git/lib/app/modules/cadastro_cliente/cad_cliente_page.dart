import 'package:aula2026_git/app/data/services/database_helper.dart';
import 'package:flutter/material.dart';

class CadClientePage extends StatefulWidget {
  const CadClientePage({super.key});

  @override
  State<CadClientePage> createState() => _CadClientePageState();
}

class _CadClientePageState extends State<CadClientePage> {
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _clientes = [];
  String _mensagem = '';
  bool _carregando = false;

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    setState(() => _carregando = true);

    try {
      final lista = await _databaseHelper.listarClientes();
      debugPrint('Clientes: $lista');
      setState(() {
        _clientes = lista;
        _mensagem = '';
      });
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao carregar clientes: $e';
      });
    } finally {
      setState(() => _carregando = false);
    }
  }

  void _editarCliente(Map<String, dynamic> cliente) {
    setState(() {
      _codigoController.text = cliente['codigo'].toString();
      _nomeController.text = cliente['nome'] ?? '';
      _mensagem = 'Cliente carregado para edição';
    });
  }

  void _limparCampos() {
    _codigoController.clear();
    _nomeController.clear();
  }

  Future<void> _salvarCliente() async {
    final codigoTexto = _codigoController.text.trim();
    final nome = _nomeController.text.trim();

    if (nome.isEmpty) {
      setState(() {
        _mensagem = 'Informe o nome do cliente';
      });
      return;
    }

    setState(() => _carregando = true);

    try {
      final cliente = {
        'nome': nome,
        'dataCadastro': DateTime.now().toIso8601String(),
      };

      if (codigoTexto.isNotEmpty) {
        final codigo = int.parse(codigoTexto);
        await _databaseHelper.atualizarCliente(codigo, cliente);
        setState(() {
          _mensagem = 'Cliente atualizado com sucesso!';
        });
      } else {
        final codigoGerado = await _databaseHelper.inserirCliente(cliente);
        setState(() {
          _mensagem = 'Cliente cadastrado com sucesso! Código: $codigoGerado';
        });
      }

      _limparCampos();
      await _carregarClientes();
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao salvar cliente: $e';
      });
    } finally {
      setState(() => _carregando = false);
    }
  }

  Future<void> _deletarCliente(int codigo, String nome) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir cliente'),
        content: Text('Deseja excluir o cliente "$nome"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    setState(() => _carregando = true);

    try {
      await _databaseHelper.delete(codigo);

      if (_codigoController.text.trim() == codigo.toString()) {
        _limparCampos();
      }

      await _carregarClientes();
      setState(() {
        _mensagem = 'Cliente excluído com sucesso!';
      });
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao excluir cliente: $e';
      });
    } finally {
      setState(() => _carregando = false);
    }
  }

  bool get _estaEditando => _codigoController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_estaEditando ? 'Editar Cliente' : 'Cadastro de Clientes'),
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
                    TextField(
                      controller: _codigoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Código',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do cliente',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _salvarCliente(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _carregando ? null : _salvarCliente,
                            icon: Icon(
                              _estaEditando ? Icons.update : Icons.save,
                            ),
                            label: Text(_estaEditando ? 'Atualizar' : 'Salvar'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _carregando
                                ? null
                                : () {
                                    setState(() {
                                      _limparCampos();
                                      _mensagem = '';
                                    });
                                  },
                            icon: const Icon(Icons.clear),
                            label: const Text('Limpar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_mensagem.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _mensagem.contains('sucesso')
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_mensagem),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: _carregando && _clientes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _clientes.isEmpty
                  ? const Center(child: Text('Nenhum cliente cadastrado'))
                  : ListView.builder(
                      itemCount: _clientes.length,
                      itemBuilder: (context, index) {
                        final cliente = _clientes[index];
                        return Card(
                          child: ListTile(
                            title: Text(cliente['nome'] ?? ''),
                            subtitle: Text('Código: ${cliente['codigo']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _editarCliente(cliente),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _deletarCliente(
                                    cliente['codigo'],
                                    cliente['nome'] ?? '',
                                  ),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nomeController.dispose();
    super.dispose();
  }
}
