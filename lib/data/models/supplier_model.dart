class Supplier {
  final String name;
  final String address;
  final double distance;
  final dynamic rating;

  Supplier(
      {required this.name,
      required this.address,
      required this.distance,
      required this.rating});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'],
      address: json['address'],
      distance: json['distance'],
      rating: double.parse(json['rating'].toString()),
    );
  }
}
