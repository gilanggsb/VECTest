// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:vec_gilang/src/models/models.dart';
import 'package:vec_gilang/src/repositories/product_repository.dart';
import 'package:vec_gilang/src/widgets/snackbar_widget.dart';

class ProductDetailController extends GetxController {
  ProductDetailController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final ProductRepository _productRepository;
  String productId = Get.arguments;

  late Rx<ProductRatingRequest> _productRatingsRequest;
  ProductRatingRequest get productRatingRequest => _productRatingsRequest.value;

  late final Rx<ProductModel?> _product = Rx<ProductModel?>(null);
  ProductModel? get product => _product.value;

  final RxList<ProductRating> _productRatings = RxList<ProductRating>([]);
  List<ProductRating> get productRatings => _productRatings.value;

  @override
  void onInit() {
    getDetail();
    super.onInit();
  }

  void getDetail() async {
    _isLoading.value = true;
    _productRatingsRequest = ProductRatingRequest(
      limit: 10,
      page: 1,
      productId: productId,
      sortColumn: 'created_at',
      sortOrder: 'desc',
    ).obs;
    try {
      final results = await ([
        _productRepository.getProductDetail(productId),
        _productRepository.getProductRatings(productRatingRequest),
      ]).wait;

      final product = results[0] as ProductModel?;
      final productRatings = results[1] as List<ProductRating>?;

      if (product != null) {
        _product.value = product;
      }

      if (productRatings != null) {
        _productRatings.value = productRatings;
      }
    } catch (e) {
      SnackbarWidget.showFailedSnackbar(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
