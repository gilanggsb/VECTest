import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/app/routes/route_name.dart';

import '../../../../../models/product_model.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;

  ProductListController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _products = Rx<List<ProductModel>>([]);
  final _favoriteProducts = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;
  List<ProductModel> get favoriteProducts => _favoriteProducts.value;
  final ScrollController scrollController = ScrollController();

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveFavoriteProduct = false.obs;

  bool get isLoadingRetrieveFavoriteProduct =>
      _isLoadingRetrieveFavoriteProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  //The number of product retrieved each time a call is made to server
  final _limit = 8;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  @override
  void onInit() {
    super.onInit();
    initProduct();
    initScrollController();
  }

  void initProduct() {
    getProducts();
    getFavoriteProducts();
  }

  void initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoadingRetrieveMoreProduct &&
          !_isLastPageProduct.value) {
        getMoreProducts();
      }
    });
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = productList.data;
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = [..._products.value, ...productList.data];
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    Get.toNamed(RouteName.productDetail, arguments: product.id);
  }

  void setFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;
    await _productRepository.saveOrRemoveProductFromFavorite(product);
    getFavoriteProducts();
  }

  void removeFavorite(ProductModel product) async {
    await _productRepository.saveOrRemoveProductFromFavorite(product);
    initProduct();
  }

  void getFavoriteProducts() async {
    _isLoadingRetrieveFavoriteProduct.value = true;
    final favProducts = await _productRepository.getFavoriteProducts();
    _favoriteProducts.value = favProducts;
    _isLoadingRetrieveFavoriteProduct.value = false;
  }
}
