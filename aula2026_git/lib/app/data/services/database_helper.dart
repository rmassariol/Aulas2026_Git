import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _nomeBanco = 'clientes.db';
  static const int _versaoBanco = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final caminhoBanco = join(await getDatabasesPath(), _nomeBanco);

    return await openDatabase(
      caminhoBanco,
      version: _versaoBanco,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes (
        codigo INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        dataCadastro TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Lógica para atualizar o banco de dados, se necessário
      // await db.execute("ALTER TABLE clientes ADD COLUMN telefone TEXT NULL");
    }
    if (oldVersion < 3) {
      // Lógica para atualizar o banco de dados, se necessário
    }
  }

  Future<int> inserirCliente(Map<String, dynamic> cliente) async {
    final db = await database;
    cliente.remove(
      'codigo',
    ); // remove o código para não conflitar com autoincremento

    return await db.insert('clientes', cliente);
  }

  Future<List<Map<String, dynamic>>> listarClientes() async {
    final db = await database;
    return await db.query('clientes', orderBy: 'codigo ASC');
  }

  Future<int> atualizarCliente(int codigo, Map<String, dynamic> cliente) async {
    final db = await database; // abre o banco
    cliente.remove(
      'codigo',
    ); // remove o código para não tentar alterar a chave primária

    return await db.update(
      'clientes', // nome da tabela
      cliente, // dados que serão atualizados
      where: 'codigo = ?', // condição do update
      whereArgs: [codigo], // valor da condição
    );
  }

  Future<int> delete(int codigo) async {
    final db = await database; // abre o banco

    return await db.delete(
      'clientes', // nome da tabela
      where: 'codigo = ?', // condição do delete
      whereArgs: [codigo], // valor da condição
    );
  }
  // Future<List<Map<String, dynamic>>> listarClientesAtivos() async {
  //   final db = await database;

  //   return await db.query(
  //     'clientes',
  //     where: 'ativo = ?',
  //     whereArgs: [1], // 1 para ativo, 0 para inativo
  //     orderBy: 'codigo ASC',
  //   );
  // }

  // Future<List<Map<String, dynamic>>> listarClientesParametroNomeado({
  //   String? nome,
  //   String? cidade,
  //   String? email,
  //   bool? ativo,
  //   int? codigoInicial,
  //   int? codigoFinal,
  // }) async {
  //   final db = await database;

  //   List<String> conditions = [];
  //   List<dynamic> args = [];

  //   if (nome != null && nome.isNotEmpty) {
  //     conditions.add('nome LIKE ?');
  //     args.add('%$nome%');
  //   }

  //   if (cidade != null && cidade.isNotEmpty) {
  //     conditions.add('cidade = ?');
  //     args.add(cidade);
  //   }

  //   if (email != null && email.isNotEmpty) {
  //     conditions.add('email LIKE ?');
  //     args.add('%$email%');
  //   }

  //   if (ativo != null) {
  //     conditions.add('ativo = ?');
  //     args.add(ativo ? 1 : 0);
  //   }

  //   if (codigoInicial != null) {
  //     conditions.add('codigo >= ?');
  //     args.add(codigoInicial);
  //   }

  //   if (codigoFinal != null) {
  //     conditions.add('codigo <= ?');
  //     args.add(codigoFinal);
  //   }

  //   return await db.query(
  //     'clientes',
  //     where: conditions.isEmpty ? null : conditions.join(' AND '),
  //     whereArgs: conditions.isEmpty ? null : args,
  //     orderBy: 'codigo ASC',
  //   );
  // }
}
