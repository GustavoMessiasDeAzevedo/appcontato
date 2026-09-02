import 'package:flutter/painting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await abrirBanco();
    return _db!;
  }

  static Future<Database> abrirBanco() async {
    final caminho = join(await getDatabasesPath(), 'contatos.db');

    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) {
        return db.execute('''
          CREATE TABLE contatos 
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            iniciais TEXT,
            nome TEXT,
            telefone TEXT,
            favoritos INTEGER
          )
          ''');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> buscarContatos() async {
    final db = await DatabaseHelper.database;
    return db.query('contatos');
  }

  static Future<void> inserirContatos(
    String iniciais,
    String nome,
    String telefone,
  ) async {
    final db = await DatabaseHelper.database;
    await db.insert('contatos', {
      'iniciais': iniciais,
      'nome': nome,
      'telefone': telefone,
      'favoritos': 0,
    });
  }
}
