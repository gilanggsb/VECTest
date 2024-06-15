import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:vec_gilang/src/models/request/update_profile_request_model.dart';
import 'package:vec_gilang/src/repositories/user_repository.dart';
import 'package:vec_gilang/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_utils.dart';
import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode ?? '';

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void changeImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile == null) return;
    _isLoadPictureFromPath.value = true;
    _profilePictureUrlOrPath.value = pickedFile.path;
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  void saveData() async {
    try {
      if (!(formKey.currentState?.validate() ?? false)) {
        return SnackbarWidget.showFailedSnackbar("Please fill out the form");
      }

      final updatedUser = UpdateProfileRequestModel(
        dateOfBirth: DateUtil.getShortServerFormatDateString(birthDate),
        email: etEmail.text,
        name: etFullName.text,
        gender: _gender.value,
        height: etHeight.text,
        weight: etWeight.text,
        method: "PUT",
        profilePicture: File(profilePictureUrlOrPath),
      );

      await _userRepository.updateProfile(updatedUser);
      SnackbarWidget.showSuccessSnackbar("Update Profile Success");
      loadUserFromServer();
    } catch (e) {
      log("saveData error : ${e.toString()}");
      SnackbarWidget.showFailedSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName should not be empty';
    }

    if (!AppUtils.isNumeric(value)) {
      return '$fieldName should be a number';
    }

    if (int.parse(value) <= 0) {
      return '$fieldName not less than 0';
    }

    return null;
  }
}
