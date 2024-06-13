import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/models/models.dart';
import 'package:vec_gilang/src/utils/api_service.dart';
import 'package:vec_gilang/src/utils/pretty_logger_interceptors.dart';

import '../src/constants/endpoint.dart';
import '../src/utils/curl_logger_interceptors.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetStorage>(GetStorage());

    Get.put<Dio>(
      Dio(
        BaseOptions(
          baseUrl: Endpoint.baseUrl,
          connectTimeout: const Duration(minutes: 1),
          followRedirects: false,
          contentType: 'application/json',
        ),
      )..interceptors.addAll([
          CustomInterceptors(),
          CurlLoggerDioInterceptor(),
          PrettyDioLogger(),
          // TalkerDioLogger(
          //   settings: TalkerDioLoggerSettings(
          //     printRequestHeaders: true,
          //     printResponseHeaders: true,
          //     printResponseMessage: true,
          //     // Blue http requests logs in console
          //     requestPen: AnsiPen()..blue(),
          //     // Green http responses logs in console
          //     responsePen: AnsiPen()..green(),
          //     // Error http logs in console
          //     errorPen: AnsiPen()..red(),
          //   ),
          // ),
        ]),
      permanent: true,
    );
    Get.put<ApiService>(
      ApiService(
        client: Get.find<Dio>(),
      ),
    );
  }
}
