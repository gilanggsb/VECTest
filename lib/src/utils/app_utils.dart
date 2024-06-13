import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:vec_gilang/src/constants/endpoint.dart';
import 'package:vec_gilang/src/widgets/snackbar_widget.dart';

class AppUtils {
  static final phoneRegex = RegExp(r'^[1-9][0-9]*$');
  // ignore: unnecessary_string_escapes
  static final emailRegex = RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
  static void copyLink(String data, String successMessage) {
    Clipboard.setData(ClipboardData(text: data)).then((_) {
      SnackbarWidget.showNeutralSnackbar(successMessage);
    });
  }

  static List<String> whiteListApi = [
    Endpoint.postSignIn,
  ];

  static Future<FormData> createFormData(Map<String, dynamic> params) async {
    final Map<String, dynamic> formDataMap = {};

    for (var entry in params.entries) {
      if (entry.value is File) {
        formDataMap[entry.key] = await MultipartFile.fromFile(
          (entry.value as File).path,
          filename: (entry.value as File).path.split('/').last,
        );
      } else {
        formDataMap[entry.key] = entry.value;
      }
    }

    return FormData.fromMap(formDataMap);
  }

  static bool isNumeric(String str) {
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(str);
  }
}
