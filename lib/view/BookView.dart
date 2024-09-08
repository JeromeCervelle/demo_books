import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final List<Map<String, dynamic>> books;

  const BookView({required this.books, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des livres"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: const Icon(Icons.book),
        actions: const [Icon(Icons.person)],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book['title'] ?? 'No Title'),
            subtitle: Text('Price: \$${book['price']?.toStringAsFixed(2) ?? 'Unknown'}'),
          );
        },
      ),
    );
  }
}
