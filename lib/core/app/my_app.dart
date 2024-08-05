import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suppliers_products_finder_app/views/products_view/products_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nearby Suppliers',
      home: ProductListView(),
    );
  }
}
