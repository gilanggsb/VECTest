import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/number_ext.dart';

import '../../../../../constants/color.dart';
import 'components.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    super.key,
    required this.controller,
  });

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.product?.name ?? "",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              controller.product?.price.inRupiah() ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: yellow500,
                  size: 16,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  controller.product?.ratingAverage ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "(${controller.product?.reviewCount ?? "-"} Review)",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
