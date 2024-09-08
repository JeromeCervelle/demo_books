import 'package:flutter/material.dart';
import 'package:demo/repository/Database.dart'; // Assurez-vous que ce chemin est correct
import 'package:demo/view/BookView.dart';

class BookController extends StatefulWidget {
  const BookController({super.key});

  @override
  _BookControllerState createState() => _BookControllerState();
}

class _BookControllerState extends State<BookController> {
  late Future<List<Map<String, dynamic>>> _booksFuture;
  final DatabaseClient _databaseClient = DatabaseClient();

  @override
  void initState() {
    super.initState();
    _booksFuture = _initializeDatabaseAndFetchBooks();
  }

  Future<List<Map<String, dynamic>>> _initializeDatabaseAndFetchBooks() async {
    try {
      await _databaseClient.database; // Assure que la base de données est initialisée
      return await _databaseClient.fetchBooks();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Affiche une liste vide ou un autre widget pour indiquer l'absence de données
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.book, size: 50, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Aucun livre trouvé',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return ListTile(
                  title: Text(book['title'] ?? 'No Title'),
                  subtitle: Text('Price: \$${book['price']?.toStringAsFixed(2) ?? 'Unknown'}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

