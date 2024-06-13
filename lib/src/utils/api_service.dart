import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

class ApiService {
  final Dio _client;

  ApiService({
    required Dio client,
  }) : _client = client;

  Future<BaseResponse<T>> post<T>(
    String endpoints, {
    Map<String, dynamic>? body,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final Response response = await _client.post(
        endpoints,
        data: jsonEncode(body),
        options: options,
      );
      return parseResponse(response, fromJsonT);
    } on DioException catch (e) {
      return parseError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse<T>> get<T>(
    String endpoints, {
    Map<String, dynamic>? queryParams,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final Response response = await _client.get(endpoints,
          queryParameters: queryParams, options: options);
      return parseResponse(response, fromJsonT);
    } on DioException catch (e) {
      return parseError(e);
    } catch (e) {
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

  BaseResponse<T> parseResponse<T>(
      Response response, T Function(dynamic) fromJsonT) {
    try {
      final BaseResponse<T> baseResponse =
          BaseResponse.fromJson(response.data, fromJsonT);
      // if (baseResponse.status == 200) {
      return baseResponse;
      // }
      // throw ServerFailure(baseResponse.msg);
    } catch (e) {
      rethrow;
    }
  }

  dynamic parseError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      BadResponse badResponse = BadResponse.fromJson(e.response?.data);
      throw badResponse;
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
