import 'package:dio/dio.dart';
import 'package:vec_gilang/src/features/dashboard/component/dashboard_controller.dart';
import 'package:vec_gilang/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:vec_gilang/src/repositories/product_repository.dart';
import 'package:vec_gilang/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/utils/isar_service.dart';

import '../profile/component/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
      isarService: Get.find<IsarService>(),
    ));

    Get.put(
      DashboardController(),
    );

    Get.put(ProfileController(
      userRepository: Get.find<UserRepository>(),
    ));

    Get.put(ProductListController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
