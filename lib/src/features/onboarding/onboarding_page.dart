import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/onboarding_controller.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.contents.length,
              onPageChanged: (int page) => controller.setCurrentPage(page),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.7,
                      child: Image.asset(
                        controller.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      controller.titles[index],
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      controller.contents[index],
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(controller.contents.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Obx(
                    () {
                      final isLastPage = controller.currentPage ==
                          controller.contents.length - 1;
                      final isFirstPage = controller.currentPage == 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (!isFirstPage)
                            ElevatedButton(
                              onPressed: () {
                                controller.pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: const Text('Back'),
                            ),
                          if (isFirstPage) const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              if (isLastPage) return controller.gotoLoginPage();

                              controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Text(isLastPage ? 'Finish' : 'Next'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 30,
              child: TextButton(
                onPressed: controller.gotoLoginPage,
                child: const Text('Skip'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
