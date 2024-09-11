import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/view/AddBookView.dart';
import 'package:demo/viewmodels/BookViewModel.dart';
import 'package:demo/view/BookDetailView.dart'; // Importez la page des détails

class BookView extends StatefulWidget {

  @override
    _BookViewState createState() => _BookViewState();
  }

class _BookViewState extends State<BookView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Charger les livres au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BooksViewModel>(context, listen: false).loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Liste des Livres',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Action lorsque l'icône de recherche est pressée
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Action lorsque l'icône de menu est pressée
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.amber,
            height: 4.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.deepPurple),
              title: const Text('Ajouter un livre'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddBookView(),
                )).then((_) {
                  if (_scaffoldKey.currentState != null) {
                    Navigator.of(context).pop(); // Fermer le Drawer
                  }
                });
              },
            ),
            // Ajoutez d'autres éléments de menu ici
          ],
        ),
      ),
      body: Consumer<BooksViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.books.isEmpty) {
            return const Center(child: Text('Aucun livre trouvé.'));
          }

          return ListView.builder(
            itemCount: viewModel.books.length,
            itemBuilder: (context, index) {
              final book = viewModel.books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text('Price: \$${book.price.toStringAsFixed(2)}'),
                onTap: () {
                  viewModel.navigateToBookDetail(context, book);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pour tester l'insertion de livres dans la base de données
          Provider.of<BooksViewModel>(context, listen: false).loadBooks();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

}
