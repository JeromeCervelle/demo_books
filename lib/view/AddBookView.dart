import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Book.dart';
import '../viewmodels/BookViewModel.dart';

class AddBookView extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un Livre',
          style: TextStyle(
            fontSize: 20, // Taille du texte
            fontWeight: FontWeight.bold, // Poids du texte
            color: Colors.white, // Couleur du texte
          ),
        ),
        backgroundColor: Colors.deepPurple, // Couleur de fond de l'AppBar
        elevation: 5, // Ombre sous l'AppBar
        iconTheme: IconThemeData(color: Colors.white), // Couleur des icônes de l'AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _insertBook();
                  }
                },
                child: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Couleur de fond du bouton
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18, // Taille du texte du bouton
                    fontWeight: FontWeight.bold, // Poids du texte du bouton
                    foreground: Paint()..color = Colors.white, // Couleur du texte du bouton
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertBook() async {
    final title = _titleController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    final book = Book(
      authorId: 1, // Vous pouvez ajuster cette valeur selon vos besoins
      title: title,
      price: price,
      createdAt: DateTime.now().toIso8601String(),
    );

    final viewModel = Provider.of<BooksViewModel>(context, listen: false);
    await viewModel.addBook(book);

    Navigator.pop(context); // Retourne à la page précédente après l'ajout
  }
}
