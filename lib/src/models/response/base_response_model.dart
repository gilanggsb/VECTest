import '../models.dart';

class BaseResponse<T> {
  final int? status;
  final String? message;
  final T? data;
  final Links? links;

  BaseResponse({
    this.status,
    this.message,
    this.data,
    this.links,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      BaseResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : fromJsonT(json["data"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
        "status": status,
        "message": message,
        "data": toJsonT(data as T),
        "links": links?.toJson(),
      };
}
