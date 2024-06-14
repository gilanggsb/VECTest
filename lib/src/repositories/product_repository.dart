import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vec_gilang/src/utils/isar_service.dart';

import '../constants/endpoint.dart';
import '../constants/local_data_key.dart';
import '../models/models.dart';
import '../utils/networking_util.dart';

class ProductRepository {
  final Dio _client;
  final GetStorage _local;
  final IsarService _isarService;

  ProductRepository(
      {required Dio client,
      required GetStorage local,
      required IsarService isarService})
      : _client = client,
        _local = local,
        _isarService = isarService;

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final productListResponse =
          ProductListResponseModel.fromJson(responseJson.data);
      return await syncProductWithFavorite(productListResponse);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> saveOrRemoveProductFromFavorite(
    ProductModel product,
  ) async {
    try {
      await _isarService.saveOrRemove<ProductModel>(
          product, (product) => product.isarId);
    } catch (e) {
      debugPrint("saveProductToFavorite error $e");
    }
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final favoriteProducts = await _isarService.getAll<ProductModel>();
      return favoriteProducts;
    } catch (e) {
      debugPrint("saveProductToFavorite error $e");
      rethrow;
    }
  }

  Future<ProductListResponseModel> syncProductWithFavorite(
      ProductListResponseModel productResponse) async {
    final favoriteProducts = await getFavoriteProducts();
    // mapped favorite products
    final mappedProducts = productResponse.data.map((product) {
      final favProduct = favoriteProducts.firstWhereOrNull(
          (ProductModel favProduct) => favProduct.id == product.id);

      if (favProduct != null) {
        product.isarId = favProduct.isarId;
        product.isFavorite = !product.isFavorite;
      }

      return product;
    }).toList();

    // mappedProducts.map((element) => print("cek element ${element.toJson()}"));
    return productResponse.copyWith(data: mappedProducts);
  }
}
