// To parse this JSON data, do
//
//     final productRatingRequest = productRatingRequestFromJson(jsonString);

import 'dart:convert';

ProductRatingRequest productRatingRequestFromJson(String str) =>
    ProductRatingRequest.fromJson(json.decode(str));

String productRatingRequestToJson(ProductRatingRequest data) =>
    json.encode(data.toJson());

class ProductRatingRequest {
  final int? page;
  final int? limit;
  final String? sortColumn;
  final String? sortOrder;
  final String? productId;

  ProductRatingRequest({
    this.page,
    this.limit,
    this.sortColumn,
    this.sortOrder,
    this.productId,
  });

  ProductRatingRequest copyWith({
    int? page,
    int? limit,
    String? sortColumn,
    String? sortOrder,
    String? productId,
  }) =>
      ProductRatingRequest(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        sortColumn: sortColumn ?? this.sortColumn,
        sortOrder: sortOrder ?? this.sortOrder,
        productId: productId ?? this.productId,
      );

  factory ProductRatingRequest.fromJson(Map<String, dynamic> json) =>
      ProductRatingRequest(
        page: json["page"],
        limit: json["limit"],
        sortColumn: json["sort_column"],
        sortOrder: json["sort_order"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "sort_column": sortColumn,
        "sort_order": sortOrder,
        "product_id": productId,
      };
}
