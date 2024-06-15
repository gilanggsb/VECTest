import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:vec_gilang/src/constants/local_data_key.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/models/models.dart';
import 'package:vec_gilang/src/utils/api_service.dart';
import 'package:vec_gilang/src/utils/isar_service.dart';

import '../constants/endpoint.dart';
import '../utils/app_utils.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;
  final ApiService _apiService = getx.Get.find<ApiService>();
  final IsarService _isarService = getx.Get.find<IsarService>();

  UserRepository({
    required Dio client,
    required GetStorage local,
  })  : _client = client,
        _local = local;

  Future<void> login(
    LoginModel login,
  ) async {
    //Artificial delay to simulate logging in process
    // await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
    // _local.write(
    //     LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");
    try {
      BaseResponse<LoginResponse> response =
          await _apiService.post<LoginResponse>(
        Endpoint.postSignIn,
        body: login.toJson(),
        fromJsonT: (json) => LoginResponse.fromJson(
          json as Map<String, dynamic>,
        ),
      );

      log("cek token login ${response.data?.token}");

      _local.write(
        LocalDataKey.token,
        response.data?.token,
      );
    } on BadResponse catch (e) {
      throw e.message ?? '';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    // await Future.delayed(const Duration(seconds: 2));
    try {
      await _apiService.post<List>(
        Endpoint.postSignOut,
        fromJsonT: (json) => json,
      );

      [
        _local.remove(LocalDataKey.token),
        _isarService.logout(),
      ].wait;
    } on BadResponse catch (e) {
      throw e.message ?? '';
    } catch (e) {
      rethrow;
    }
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      await getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> downloadFile(
    DownloadFileModel downloadFile,
  ) async {
    try {
      return await _apiService.downloadFile(downloadFile);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProfile(UpdateProfileRequestModel model) async {
    try {
      final formData = await AppUtils.createFormData(model.toMap());
      print("cek update ${model.toMap()}");
      final response = await _apiService.uploadFormData(
        Endpoint.postUpdateProfile,
        formData: formData,
        fromJsonT: (json) => UserModel.fromJson(json),
      );
      return response.data;
    } on BadResponse catch (e) {
      log("cekk user ${e.toJson()}");
      throw e.message ?? '';
    } catch (e) {
      rethrow;
    }
  }
}
