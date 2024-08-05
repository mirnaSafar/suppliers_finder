import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:suppliers_products_finder_app/core/extensions/size_extensions.dart';
import 'package:suppliers_products_finder_app/data/models/product_model.dart';
import 'package:suppliers_products_finder_app/views/suppliers_view/suppliers_controller.dart';

class SupplierListView extends StatefulWidget {
  final Product product;

  const SupplierListView({super.key, required this.product});

  @override
  State<SupplierListView> createState() => _SupplierListViewState();
}

class _SupplierListViewState extends State<SupplierListView> {
  late SupplierController supplierController;
  @override
  void initState() {
    super.initState();
    supplierController = Get.put(SupplierController(product: widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suppliers for ${widget.product.name}')),
      body: Obx(() {
        return supplierController.isLoadingSuppliers.value
            ? const Center(child: CircularProgressIndicator())
            : supplierController.suppliers.isEmpty
                ? const Center(
                    child: Text('no suppliers for this product'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              context.screenWidth(20)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                child: const Text('rating'),
                                                onPressed: () {
                                                  Get.back();
                                                  supplierController
                                                      .sortByRating();
                                                },
                                              ),
                                              const Divider(),
                                              TextButton(
                                                child: const Text('distance'),
                                                onPressed: () {
                                                  Get.back();
                                                  supplierController
                                                      .sortByDistance();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                useSafeArea: true);
                          },
                          child: const Text('Filter'),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: supplierController.suppliers.length,
                          itemBuilder: (context, index) {
                            final supplier =
                                supplierController.suppliers[index];
                            return ListTile(
                              title: Text(supplier.name),
                              subtitle: Text(
                                  '${supplier.address} (${supplier.distance.toStringAsFixed(1)} km)'),
                              trailing: SizedBox(
                                width: context.screenWidth(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: context.screenWidth(30),
                                      color: Colors.amber,
                                    ),
                                    Text(supplier.rating.toString()),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
