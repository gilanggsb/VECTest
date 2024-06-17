import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/constants/local_data_key.dart';

import '../../../../app/routes/route_name.dart';

class SplashController extends GetxController {
  final GetStorage _storage = Get.find<GetStorage>();
  SplashController();

  @override
  void onReady() {
    super.onReady();
    checkUser();
  }

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 3));

    bool? isBoarded = _storage.read(LocalDataKey.onboarded);
    if (isBoarded == null) return Get.offNamed(RouteName.onboarding);

    String? token = _storage.read(LocalDataKey.token);
    if (token == null) return Get.offNamed(RouteName.login);
    Get.offNamed(RouteName.dashboard);
  }
}
