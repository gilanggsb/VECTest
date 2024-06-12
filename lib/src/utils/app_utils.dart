import 'package:flutter/services.dart';
import 'package:vec_gilang/src/widgets/snackbar_widget.dart';

class AppUtils {
  static final phoneRegex = RegExp(r'^[1-9][0-9]*$');
  static void copyLink(String data, String successMessage) {
    Clipboard.setData(ClipboardData(text: data)).then((_) {
      SnackbarWidget.showNeutralSnackbar(successMessage);
    });
  }
}
