import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:suppliers_products_finder_app/data/repositories/products_repo.dart';
import '../../data/models/product_model.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxBool isLoadingProducts = true.obs;

  Future<void> fetchProducts() async {
    isLoadingProducts.value = true;
    ProductsRepository().fetchProducts().then((value) {
      products.value = value;

      isLoadingProducts.value = false;
    });
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
}
