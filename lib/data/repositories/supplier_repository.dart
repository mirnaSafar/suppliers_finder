import 'dart:convert';

import 'package:get/get.dart';
import 'package:suppliers_products_finder_app/core/app/app_config.dart';
import 'package:suppliers_products_finder_app/data/models/product_model.dart';
import 'package:suppliers_products_finder_app/data/models/supplier_model.dart';
import 'package:suppliers_products_finder_app/core/services/location_service.dart';
import 'package:http/http.dart' as http;

class SupplierRepository {
  Future<List<Supplier>?> fetchSuppliers(Product product) async {
    final locationController = Get.find<LocationService>();
    final location = locationController.currentPosition;

    if (location == null) {
      Get.snackbar('Error', 'Location not available.');
      return null;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=${location.latitude},${location.longitude}&radius=10000' // Search within 10 km radius
        '&keyword=${product.category}&key=${AppConfig.googlePlacesApiKey}');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<Supplier> suppliers = [];
      for (var place in jsonData['results']) {
        final name = place['name'];
        final address = place['vicinity'];
        final rating = place['rating'];
        final distance = locationController.calculateDistance(
            location.latitude,
            location.longitude,
            place['geometry']['location']['lat'],
            place['geometry']['location']['lng']);
        suppliers.add(Supplier(
            name: name, address: address, distance: distance, rating: rating));
      }

      return suppliers;
    } else {
      Get.snackbar('Error', 'Failed to fetch suppliers.');
    }
    return null;
  }
}
