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

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert(
      'book',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> fetchBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('book');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }
}
