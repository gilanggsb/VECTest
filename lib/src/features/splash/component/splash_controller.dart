import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  void onReady() {
    super.onReady();
    checkUser();
  }

  void checkUser() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(RouteName.login);
    });
  }
}
