class Product {
  final int id;
  final String name;
  final String category;
  final String image;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
    );
  }
}
