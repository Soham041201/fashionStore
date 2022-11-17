class Product {
  final int id;

  final String title;
  final String description;
  final String category;
  final double price;
  final String image;
  int quantity;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.image,
      this.quantity = 1});

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'] ?? 0,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        category: map['category'] ?? '',
        price: map['price'].toDouble() ?? 0,
        image: map['image'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'image': image,
    };
  }
}
