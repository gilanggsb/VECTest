import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color.dart';
import '../constants/icon.dart';

class SnackbarWidget {
  static void showNeutralSnackbar(String message, {int seconds = 3}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: Duration(seconds: seconds),
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
    ));
  }

  static void showSuccessSnackbar(String message, {int seconds = 3}) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(message,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 14,
            color: green600,
            fontWeight: FontWeight.w600,
          )),
      duration: Duration(seconds: seconds),
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(16),
      backgroundColor: green50,
      borderRadius: 12,
      icon: Image.asset(ic_check_round, width: 24, height: 24),
    ));
  }

  static void showFailedSnackbar(String message, {int seconds = 3}) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 14,
          color: red600,
          fontWeight: FontWeight.w600,
        ),
      ),
      duration: Duration(seconds: seconds),
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(16),
      backgroundColor: red50,
      borderRadius: 12,
      icon: Image.asset(ic_failed_round, width: 24, height: 24),
    ));
  }

  static void showProgressSnackbar(
    String title,
  ) {
    final ProgressController controller = Get.put(ProgressController());
    Get.snackbar(
      title,
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      messageText: Obx(
        () => Column(
          children: [
            const Text(
              'Please wait...',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: controller.progress.value,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressController extends GetxController {
  var progress = 0.0.obs;

  void updateProgress(double value) {
    progress.value = value;
  }
}
