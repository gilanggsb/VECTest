import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/app/routes/route_name.dart';
import 'package:vec_gilang/src/constants/local_data_key.dart';
import 'package:vec_gilang/src/widgets/snackbar_widget.dart';

import '../utils/app_utils.dart';

class CustomInterceptors extends Interceptor {
  final GetStorage _local = getx.Get.find<GetStorage>();
  CustomInterceptors();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Authorization'] =
        'Bearer ${_local.read(LocalDataKey.token)}';

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Kick user when statuscode 401 & current path is not whitelisted
    if (err.response?.statusCode == 401 &&
        !AppUtils.whiteListApi.contains(err.requestOptions.path)) {
      SnackbarWidget.showFailedSnackbar("Unauthenticated");
      getx.Get.offAllNamed(RouteName.login);
      _local.remove(LocalDataKey.token);
      return super.onError(err, handler);
    }
    return super.onError(err, handler);
  }
}
