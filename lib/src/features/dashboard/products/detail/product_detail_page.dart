import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/constants/color.dart';
import 'package:vec_gilang/src/constants/image.dart';

import '../../../../constants/icon.dart';
import 'components/components.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Product',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => AspectRatio(
                aspectRatio: 1 / 1,
                child: CachedNetworkImage(
                  imageUrl: controller.product?.images?.isNotEmpty == true
                      ? controller.product?.images![0].urlSmall ?? ''
                      : placeHolderImageUrl(80, 80),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    ic_error_image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            ProductInformation(controller: controller),
            const Divider(
              thickness: 2,
              color: gray200,
            ),
            ProductDescription(controller: controller),
            const Divider(
              thickness: 2,
              color: gray200,
            ),
            ProductTermsAndCondition(controller: controller),
            const Divider(
              thickness: 2,
              color: gray200,
            ),
            ProductReviews(controller: controller),
          ],
        ),
      ),
    );
  }
}
