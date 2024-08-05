import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:suppliers_products_finder_app/data/models/product_model.dart';

class ProductsRepository {
  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];
    final response = await Supabase.instance.client.from('product').select('*');

    for (var element in response) {
      products.add(Product.fromJson(element));
    }
    return products;
  }
}
