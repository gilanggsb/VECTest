import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/constants/local_data_key.dart';
import 'package:vec_gilang/src/utils/string_ext.dart';

import '../../../../app/routes/route_name.dart';

class OnBoardingController extends GetxController {
  OnBoardingController();

  final GetStorage _storage = Get.find<GetStorage>();
  final PageController pageController = PageController();

  final List<String> images = [
    'home_vesperia'.toPngImage,
    'product_detail_vesperia'.toPngImage,
  ];

  final List<String> titles = [
    'Home',
    'Product Detail',
  ];

  final List<String> contents = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.',
    'Cras vehicula eros nec lacinia pretium. Ut pulvinar tortor vel sapien venenatis, nec consectetur metus faucibus.',
  ];

  final RxInt _currentPage = 0.obs;
  int get currentPage => _currentPage.value;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setCurrentPage(int page) {
    _currentPage.value = page;
  }

  void gotoLoginPage() async {
    _storage.write(LocalDataKey.onboarded, true);
    Get.offNamed(RouteName.login);
  }
}
