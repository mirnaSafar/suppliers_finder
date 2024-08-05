import 'package:get/get.dart';
import 'package:suppliers_products_finder_app/data/models/product_model.dart';
import 'package:suppliers_products_finder_app/data/models/supplier_model.dart';
import 'package:suppliers_products_finder_app/data/repositories/supplier_repository.dart';

class SupplierController extends GetxController {
  RxList<Supplier> suppliers = <Supplier>[].obs;
  SupplierController({required this.product});
  RxBool isLoadingSuppliers = true.obs;

  final Product product;

  Future<void> fetchSuppliers(Product product) async {
    isLoadingSuppliers.value = true;
    SupplierRepository().fetchSuppliers(product).then((value) {
      suppliers.value = value ?? [];
      isLoadingSuppliers.value = false;
    });
  }

  sortByRating() {
    suppliers.sort((a, b) => double.parse(b.rating.toString())
        .compareTo(double.parse(a.rating.toString())));
  }

  sortByDistance() {
    suppliers.sort(
      (a, b) => a.distance.compareTo(b.distance),
    );
  }

  @override
  void onInit() {
    fetchSuppliers(product);
    super.onInit();
  }
}
