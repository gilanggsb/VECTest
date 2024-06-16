import 'package:dio/dio.dart';
import 'package:vec_gilang/src/repositories/product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/utils/isar_service.dart';

import 'product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
      isarService: Get.find<IsarService>(),
    ));

    Get.put(
      ProductDetailController(productRepository: Get.find<ProductRepository>()),
    );
  }
}
