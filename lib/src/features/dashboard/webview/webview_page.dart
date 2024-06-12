import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/features/dashboard/webview/component/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/app_utils.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.params.title),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppUtils.copyLink(
                controller.params.webviewUrl,
                'Tautan berhasil disalin',
              );
            },
            icon: const Icon(
              Icons.share,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(
            controller: controller.webviewController,
          ),
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Stack(),
          )
        ],
      ),
    );
  }
}
