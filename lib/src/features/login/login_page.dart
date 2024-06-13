import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text("Sign In",
              style: TextStyle(
                fontSize: 16,
                color: gray900,
                fontWeight: FontWeight.w600,
              )),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Hi, Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Sign in to your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: gray500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Phone Number',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      cursorColor: primary,
                      decoration: InputDecoration(
                        errorText: controller.errorPhoneMessage.value.isEmpty
                            ? null
                            : controller.errorPhoneMessage.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Phone Number',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  _openCupertinoCountryPicker(
                                    initialCountryPhoneCode:
                                        controller.phoneCode.value,
                                    onValuePicked: (data) {
                                      controller.phoneCode.value =
                                          data.phoneCode;
                                    },
                                  );
                                },
                                child: Text(
                                  '+${controller.phoneCode}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: gray900),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const SizedBox(
                                width: 1.5,
                                height: 48,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: gray100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller: controller.etPhone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Password',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      obscureText:
                          controller.visiblePassword.isFalse ? false : true,
                      cursorColor: primary,
                      decoration: InputDecoration(
                        errorText: controller.errorPasswordMessage.value.isEmpty
                            ? null
                            : controller.errorPasswordMessage.value,
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: -14,
                          top: 20,
                          bottom: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Password',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: ImageIcon(
                            AssetImage(ic_password),
                          ), // icon is 48px widget.
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: InkWell(
                            onTap: controller.changeVisibilityPassword,
                            child: Icon(
                              controller.visiblePassword.isFalse
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ), // icon is 48px widget.
                        ),
                      ),
                      controller: controller.etPassword,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              loginButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() => SizedBox(
        height: 52,
        width: double.infinity,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: Obx(
            () => ButtonIcon(
              isLoading: controller.isLoading.value,
              buttonColor: primary,
              textColor: white,
              textLabel: "Sign In",
              onClick: () => controller.doLogin(),
            ),
          ),
        ),
      );
}

void _openCupertinoCountryPicker(
        {required String initialCountryPhoneCode,
        required Function(Country) onValuePicked}) =>
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 150.0,
          onValuePicked: onValuePicked,
          initialCountry:
              CountryPickerUtils.getCountryByPhoneCode(initialCountryPhoneCode),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('ID'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      },
    );
