import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/context_ext.dart';
import 'package:vec_gilang/src/utils/date_util.dart';
import 'package:vec_gilang/src/utils/see_more_text.dart';

import '../../../../../constants/color.dart';
import '../../../../../constants/image.dart';
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 40,
                              height: 40,
                              imageUrl:
                                  productRating.user?.profilePicture ?? '',
                              fit: BoxFit.cover,
                              errorListener: (data) {},
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Image.asset(
                                width: 40,
                                height: 40,
                                defaultProfileImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          LayoutBuilder(
                            builder: (_, constraint) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${productRating.user?.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: constraint.minHeight,
                                  child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: yellow500,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateUtil.getTimeAgo(
                                productRating.createdAt ?? DateTime.now()),
                            style:
                                const TextStyle(fontSize: 14, color: gray600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      SeeMoreText(
                        text: productRating.review ?? '',
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        seeMoreTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
