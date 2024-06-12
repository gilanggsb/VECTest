import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vec_gilang/src/constants/local_data_key.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/models/models.dart';

import '../constants/endpoint.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login() async {
    //Artificial delay to simulate logging in process
    await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
    _local.write(
        LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    await Future.delayed(const Duration(seconds: 2));
    await _local.remove(LocalDataKey.token);
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
      getUser();
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
      String path = await _getFilePath(downloadFile.fileNameWithExt);
      final Response response = await _client.download(
        downloadFile.fullFileUrl,
        path,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes <= 0) return;
          final percentage =
              (receivedBytes / totalBytes * 100).toStringAsFixed(0);
          final progress = receivedBytes / totalBytes;
          final DownloadProgressModel downloadProgress = DownloadProgressModel(
            percentage: percentage,
            progress: progress,
            receivedBytes: receivedBytes,
            totalBytes: totalBytes,
          );
          downloadFile.downloadProgress(downloadProgress);
        },
      );
      return response;
    } on DioException catch (e) {
      return parseError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;
    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
        return "${dir.path}/$filename";
      }
      dir = Directory('/storage/emulated/0/Download/'); // for android
      if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      return "${dir.path}$filename";
    } catch (err) {
      debugPrint("Cannot get download folder path $err");
    }
    return '';
  }

  dynamic parseError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      throw 'Bad Response';
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      throw 'check your connection';
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      throw 'unable to connect to the server';
    }

    if (e.type == DioExceptionType.unknown) {
      throw 'Something went wrong';
    }
  }
}
