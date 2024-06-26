import 'package:isar/isar.dart';

part 'product_image_model.g.dart';

@embedded
class ProductImageModel {
  ProductImageModel({
    this.id,
    this.productId,
    this.path,
    this.pathSmall,
    this.url,
    this.urlSmall,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? productId;
  final String? path;
  final String? pathSmall;
  final String? url;
  final String? urlSmall;
  final String? createdAt;
  final String? updatedAt;

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      ProductImageModel(
        id: json['id'],
        productId: json['product_id'],
        path: json['path'],
        pathSmall: json['path_small'],
        url: json['image_url'],
        urlSmall: json['image_url_small'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'path': path,
        'path_small': pathSmall,
        'image_url': url,
        'image_url_small': urlSmall,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
