import 'package:dio/dio.dart';
import 'package:vec_gilang/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(SplashController());
  }
}
