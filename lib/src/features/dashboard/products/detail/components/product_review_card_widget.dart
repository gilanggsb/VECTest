import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/color.dart';
import '../../../../../constants/image.dart';
import '../../../../../models/models.dart';
import '../../../../../utils/date_util.dart';
import '../../../../../utils/see_more_text.dart';

class ProductReviewCard extends StatelessWidget {
  const ProductReviewCard({
    super.key,
    required this.productRating,
  });

  final ProductRating productRating;

  @override
  Widget build(BuildContext context) {
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
                imageUrl: productRating.user?.profilePicture ?? '',
                fit: BoxFit.cover,
                errorListener: (data) {},
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
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
              DateUtil.getTimeAgo(productRating.createdAt ?? DateTime.now()),
              style: const TextStyle(fontSize: 14, color: gray600),
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
  }
}
