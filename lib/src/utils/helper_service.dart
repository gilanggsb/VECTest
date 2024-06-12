import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class HelperService {
  static Future<bool> requestPermission() async {
    PermissionStatus result;
    result = await Permission.manageExternalStorage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getStoragePermission() async {
    if (await Permission.photos.request().isGranted) {
      return true;
    } else if (await Permission.photos.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.photos.request().isDenied) {
      return true;
    }
    // }
    return true;
  }
}
