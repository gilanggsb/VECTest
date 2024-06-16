import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vec_gilang/src/utils/context_ext.dart';

import 'components.dart';

class ProductTermsAndCondition extends StatelessWidget {
  const ProductTermsAndCondition({
    super.key,
    required this.controller,
  });

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth,
      padding: const EdgeInsets.only(top: 24, bottom: 0, right: 24, left: 24),
      child: Obx(
        () {
          final productTNCList =
              controller.product?.returnTerms?.split('\n') ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms & Conditions of Return / Refund',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                itemCount: productTNCList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}.",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          productTNCList[index],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
