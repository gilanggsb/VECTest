import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/context_ext.dart';

import '../../../../../constants/color.dart';
import 'components.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({
    super.key,
    required this.controller,
  });

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth,
      margin: const EdgeInsets.all(24),
      child: Obx(
        () {
          if (controller.productRatings.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Review ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: yellow500,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${controller.product?.ratingAverage}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "from ${controller.product?.ratingCount} rating • ${controller.product?.reviewCount} reviews",
                        style: const TextStyle(
                          fontSize: 14,
                          color: gray900,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.productRatings.length >= 3
                    ? 3
                    : controller.productRatings.length,
                separatorBuilder: (_, idx) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  final productRating = controller.productRatings[index];
                  return ProductReviewCard(productRating: productRating);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
