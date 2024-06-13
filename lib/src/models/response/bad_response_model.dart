// To parse this JSON data, do
//
//     final badResponse = badResponseFromJson(jsonString);

import 'dart:convert';

import '../models.dart';

BadResponse badResponseFromJson(String str) =>
    BadResponse.fromJson(json.decode(str));

String badResponseToJson(BadResponse data) => json.encode(data.toJson());

class BadResponse {
  final int? status;
  final String? message;
  final dynamic data;
  final Links? links;

  BadResponse({
    this.status,
    this.message,
    this.data,
    this.links,
  });

  factory BadResponse.fromJson(Map<String, dynamic> json) => BadResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "links": links?.toJson(),
      };
}
