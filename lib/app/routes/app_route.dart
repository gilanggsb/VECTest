import 'package:vec_gilang/app/routes/route_name.dart';
import 'package:vec_gilang/src/features/dashboard/component/dashboard_binding.dart';
import 'package:vec_gilang/src/features/dashboard/dashboard_page.dart';
import 'package:vec_gilang/src/features/dashboard/profile/edit/edit_profile_page.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/features/dashboard/webview/component/webview_binding.dart';
import 'package:vec_gilang/src/features/dashboard/webview/webview_page.dart';
import 'package:vec_gilang/src/features/splash/splash_page.dart';

import '../../src/features/dashboard/products/detail/detail.dart';
import '../../src/features/dashboard/profile/edit/component/edit_profile_binding.dart';
import '../../src/features/login/component/login_binding.dart';
import '../../src/features/login/login_page.dart';
import '../../src/features/splash/component/splash_binding.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: RouteName.webView,
      page: () => const WebviewPage(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: RouteName.productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
  ];
}
