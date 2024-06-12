import 'package:vec_gilang/src/constants/endpoint.dart';
import 'package:vec_gilang/src/models/models.dart';
import 'package:vec_gilang/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/helper_service.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

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

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    try {
      final isGranted = await HelperService.getStoragePermission();
      if (!isGranted) {
        throw 'Permission denied';
      }
      SnackbarWidget.showProgressSnackbar('Downloading File');
      DownloadFileModel downloadFile = DownloadFileModel(
        fullFileUrl: Endpoint.flutterTutorialPdf,
        fileNameWithExt: 'flutter_tutorial.pdf',
        downloadProgress: (downloadProgress) {
          final ProgressController controller = Get.find<ProgressController>();
          controller.updateProgress(downloadProgress.progress!);
        },
      );

      await _userRepository.downloadFile(downloadFile);
      Get.closeCurrentSnackbar();
      SnackbarWidget.showSuccessSnackbar('File Downloaded');
    } on String catch (e) {
      SnackbarWidget.showFailedSnackbar(e);
    } catch (e) {
      SnackbarWidget.showFailedSnackbar(e.toString());
    }
  }

  onOpenWebPageClick() {}

  void doLogout() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      await _userRepository.logout();
      Get.offAllNamed(RouteName.login);
    } finally {
      isLoading.value = false;
    }
  }
}
