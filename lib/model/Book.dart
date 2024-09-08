class Book {
  final int authorId;
  final String title;
  final double price;
  final String createdAt;

  Book({
    required this.authorId,
    required this.title,
    required this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'author_id': authorId,
      'title': title,
      'price': price,
      'created_at': createdAt,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      authorId: map['author_id'],
      title: map['title'],
      price: map['price'],
      createdAt: map['created_at'],
    );
  }
}
