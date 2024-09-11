import 'package:flutter/material.dart';
import '../model/Book.dart';
import '../repository/Database.dart';
import '../view/BookDetailView.dart';

class BooksViewModel extends ChangeNotifier {
  final DatabaseClient _databaseClient = DatabaseClient();
  List<Book> _books = [];
  bool _isLoading = false;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> loadBooks() async {
    _isLoading = true;
    notifyListeners();

    _books = await _databaseClient.fetchBooks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await _databaseClient.insertBook(book);
    loadBooks(); // Reload books after adding
  }

  void navigateToBookDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailView(book: book)),
    );
  }
}
