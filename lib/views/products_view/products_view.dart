import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suppliers_products_finder_app/core/extensions/size_extensions.dart';
import 'package:suppliers_products_finder_app/views/products_view/products_controller.dart';
import 'package:suppliers_products_finder_app/views/suppliers_view/suppliers_view.dart'; // Import controllers

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Suppliers')),
      body: Obx(() {
        return productController.isLoadingProducts.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.category),
                    leading: CachedNetworkImage(
                      width: context.screenWidth(5),
                      placeholder: (context, url) => const Icon(Icons.info),
                      imageUrl: product.image,
                    ),
                    onTap: () {
                      Get.to(SupplierListView(product: product));
                    },
                  );
                },
              );
      }),
    );
  }
}
