import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

typedef FromJsonT<T> = T Function(dynamic);

class ApiService {
  final Dio _client;

  ApiService({
    required Dio client,
  }) : _client = client;

  Future<BaseResponse<T>> post<T>(
    String endpoints, {
    Map<String, dynamic>? body,
    Options? options,
    required FromJsonT<T> fromJsonT,
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
    required FromJsonT<T> fromJsonT,
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

  Future<BaseResponse<T>> uploadFormData<T>(
    String endpoints, {
    required FormData formData,
    required FromJsonT<T> fromJsonT,
    Options? options,
  }) async {
    try {
      final Response response = await _client.post(
        endpoints,
        options: options?.copyWith(contentType: 'multipart/form-data'),
        data: formData,
      );
      return parseResponse(response, fromJsonT);
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

  BaseResponse<T> parseResponse<T>(Response response, FromJsonT<T> fromJsonT) {
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
    // Detailed error handling based on the type of DioException
    switch (e.type) {
      case DioExceptionType.badResponse:
        // Assuming e.response?.data is in a JSON format that matches your BadResponse model
        if (e.response?.data != null) {
          try {
            BadResponse badResponse = BadResponse.fromJson(e.response?.data);
            return badResponse; // Return the BadResponse object
          } catch (error) {
            // If parsing fails, throw a generic error
            throw 'Failed to parse error response';
          }
        } else {
          throw 'Server responded with an error but no data was received';
        }

      case DioExceptionType.connectionTimeout:
        throw 'Connection timed out. Please check your internet connection and try again.';

      case DioExceptionType.connectionError:
        // Provide a more descriptive error message if available, otherwise a generic one
        throw e.message ?? 'Connection error occurred. Please try again.';

      case DioExceptionType.receiveTimeout:
        throw 'Failed to receive a response from the server in time. Please try again later.';

      case DioExceptionType.sendTimeout:
        throw 'Failed to send request to the server in time. Please check your connection and try again.';

      case DioExceptionType.cancel:
        throw 'Request to the server was cancelled. Please try again.';

      case DioExceptionType.unknown:
        if (e.message != null && e.message!.contains('SocketException')) {
          throw 'No internet connection. Please check your network settings.';
        }
        throw 'An unknown error occurred. Please try again.';

      default:
        throw 'An unexpected error occurred. Please try again.';
    }
  }
}
