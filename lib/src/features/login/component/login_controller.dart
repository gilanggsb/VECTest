import 'package:vec_gilang/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/app_utils.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool visiblePassword = true.obs;
  var errorPasswordMessage = ''.obs;
  var errorPhoneMessage = ''.obs;

  void doLogin() async {
    try {
      isLoading.value = true;
      if (!isFormValid()) {
        return;
      }

      if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
        SnackbarWidget.showFailedSnackbar('Email atau password salah');
        return;
      }
      await _userRepository.login();
      Get.offAllNamed(RouteName.dashboard);
    } finally {
      isLoading.value = false;
    }
  }

  bool isFormValid() {
    errorPasswordMessage.value = '';
    errorPhoneMessage.value = '';

    bool isPasswordValid = validatePassword();
    bool isPhoneValid = validatePhone();

    return isPasswordValid && isPhoneValid;
  }

  bool validatePassword() {
    if (etPassword.value.text.isEmpty) {
      errorPasswordMessage.value = 'Password is required';
      return false;
    }

    if (etPassword.value.text.length < 8) {
      errorPasswordMessage.value = 'Minimum password length is 8 characters';
      return false;
    }

    return true;
  }

  bool validatePhone() {
    if (etPhone.value.text.isEmpty) {
      errorPhoneMessage.value = 'Phone is required';
      return false;
    }

    if (etPhone.value.text.length < 8 || etPhone.value.text.length > 16) {
      errorPhoneMessage.value =
          'Minimum phone length is 8 and max length is 16';
      return false;
    }

    if (!AppUtils.phoneRegex.hasMatch(etPhone.text)) {
      errorPhoneMessage.value = 'Phone number is not valid';
      return false;
    }

    return true;
  }

  void changeVisibilityPassword() {
    visiblePassword.value = !visiblePassword.value;
  }
}
