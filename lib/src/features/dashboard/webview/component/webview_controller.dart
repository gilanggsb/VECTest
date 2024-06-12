import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/models/webview_params_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  WebviewController();
  late final WebviewParamsModel params = Get.arguments;
  late final WebViewController webviewController;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          isLoading.value = true;
        },
        onPageFinished: (String url) {
          isLoading.value = false;
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(params.webviewUrl));
    super.onInit();
  }
}
