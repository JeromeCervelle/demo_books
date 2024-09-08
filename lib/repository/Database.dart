import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Book.dart';

class DatabaseClient {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE book (
        author_id INTEGER,
        title TEXT,
        price REAL,
        created_at TEXT
      )
    ''');
  }

  // Méthode d'initialisation
  Future<void> init() async {
    await database; // Assure que la base de données est initialisée
  }

  Future<List<Map<String, dynamic>>> fetchBooks() async {
    Database db = await database;
    return await db.query('book');
  }

  Future<void> insertBook(Book book) async {
    Database db = await database;
    (book.authorId == null)
        ? await db.insert('book', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,)
        : await db.update('book', book.toMap(), where: 'author_id = ?', whereArgs: [book.authorId]);
  }
}
