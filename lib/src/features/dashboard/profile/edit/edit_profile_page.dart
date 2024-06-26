import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vec_gilang/src/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/app_utils.dart';

import '../../../../constants/color.dart';
import '../../../../constants/icon.dart';
import '../../../../widgets/button_icon.dart';
import 'component/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 16,
                color: gray900,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              onPressed: () => Get.back(result: true),
              icon: const Icon(
                Icons.chevron_left,
              ),
            ),
            backgroundColor: white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            color: white,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imagePickerButton(
                                'Gallery',
                                Icons.image,
                                () {
                                  Get.back();
                                  controller.changeImage(ImageSource.gallery);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              imagePickerButton(
                                'Camera',
                                Icons.camera,
                                () {
                                  Get.back();
                                  controller.changeImage(ImageSource.camera);
                                },
                              ),
                            ],
                          ),
                        ),
                        enableDrag: false,
                      );
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                          child: Obx(() => Stack(children: [
                                if (controller.isLoadPictureFromPath)
                                  Image.file(
                                    width: 100,
                                    height: 100,
                                    File(controller.profilePictureUrlOrPath),
                                    fit: BoxFit.cover,
                                  )
                                else
                                  CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    imageUrl:
                                        controller.profilePictureUrlOrPath,
                                    fit: BoxFit.cover,
                                    errorListener: (data) {},
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      defaultProfileImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 3, sigmaY: 3),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 20,
                                          ),
                                          alignment: Alignment.center,
                                          color: Colors.black.withOpacity(0.1),
                                          child: const Text(
                                            'CHANGE',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]))),
                    ),
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
                                    text: 'Full Name',
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        cursorColor: primary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full Name can't empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
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
                          hintText: 'Full Name',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(ic_user),
                            ), // icon is 48px widget.
                          ),
                        ),
                        controller: controller.etFullName,
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
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        cursorColor: primary,
                        decoration: InputDecoration(
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
                          fillColor: gray100,
                          filled: true,
                          hintText: 'Phone Number',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 6),
                                Text(
                                  '+62',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: gray900),
                                ),
                                SizedBox(width: 12),
                                SizedBox(
                                  width: 1.5,
                                  height: 48,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: gray500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        controller: controller.etPhoneNumber,
                        enabled: false,
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
                                    text: 'Email',
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
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        cursorColor: primary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty";
                          }

                          if (!AppUtils.emailRegex.hasMatch(value)) {
                            return "Invalid email";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
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
                          hintText: 'Email',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(ic_mail),
                            ), // icon is 48px widget.
                          ),
                        ),
                        controller: controller.etEmail,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Gender',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: gray900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: outlinedButtonSwitch(
                                'Male', !controller.isGenderFemale, () {
                              controller.onChangeGender(false);
                            }),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: outlinedButtonSwitch(
                                'Female', controller.isGenderFemale, () {
                              controller.onChangeGender(true);
                            }),
                          ),
                        ],
                      )),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
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
                                          text: 'Height',
                                          style: TextStyle(color: gray900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: false),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: gray900),
                              cursorColor: primary,
                              validator: (value) =>
                                  controller.validateNumber(value, 'Height'),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: gray200, width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: gray200, width: 1.5),
                                ),
                                fillColor: white,
                                filled: true,
                                hintText: 'Height',
                                suffixText: 'cm',
                              ),
                              controller: controller.etHeight,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
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
                                          text: 'Weight',
                                          style: TextStyle(color: gray900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: false),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: gray900),
                              cursorColor: primary,
                              validator: (value) =>
                                  controller.validateNumber(value, "Weight"),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: gray200, width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: gray200, width: 1.5),
                                ),
                                fillColor: white,
                                filled: true,
                                hintText: 'Weight',
                                suffixText: 'kg',
                              ),
                              controller: controller.etWeight,
                            ),
                          ],
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
                                    text: 'Birthdate',
                                    style: TextStyle(color: gray900),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.none,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        cursorColor: primary,
                        decoration: InputDecoration(
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
                          hintText: 'Birthdate',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(ic_calendar),
                            ), // icon is 48px widget.
                          ),
                        ),
                        controller: controller.etBirthDate,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: controller.birthDate,
                            firstDate: DateTime(1920, 1),
                            lastDate: DateTime.now(),
                          ).then((pickedDate) {
                            if (pickedDate != null) {
                              controller.onChangeBirthDate(pickedDate);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ButtonIcon(
                      buttonColor: primary,
                      textColor: white,
                      textLabel: "Save Changes",
                      onClick: controller.saveData,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );

  Widget imagePickerButton(String label, IconData icon, VoidCallback onClick) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        side: const BorderSide(width: 1.5, color: gray200),
        fixedSize: const Size(400, 50),
      ),
      onPressed: onClick,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: gray900,
                ),
              ),
            ],
          )),
    );
  }

  Widget outlinedButtonSwitch(String label, bool active, onClick) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: active ? primary.withOpacity(0.1) : white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            side: BorderSide(
                width: active ? 0.0 : 1.5, color: active ? white : gray200)),
        onPressed: () {
          onClick();
        },
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: active ? primary : gray900,
              ),
            )),
      );
}
