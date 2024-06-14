import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/models/models.dart';
import 'package:vec_gilang/src/utils/api_service.dart';
import 'package:vec_gilang/src/utils/isar_service.dart';
import 'package:vec_gilang/src/utils/pretty_logger_interceptors.dart';

import '../src/constants/endpoint.dart';
import '../src/utils/curl_logger_interceptors.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<GetStorage>(GetStorage(), permanent: true);

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
        ]),
      permanent: true,
    );

    Get.put<ApiService>(
      ApiService(
        client: Get.find<Dio>(),
      ),
      permanent: true,
    );

    Get.put<IsarService>(
      IsarService()..init(IsarService.isarSchemas),
      permanent: true,
    );
  }
}
