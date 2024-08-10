import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/controllers/onboarding_controller.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/ElevatedButton.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/OnBoardingwidget.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/Positionedskip.dart';
import 'package:t_store/features/authentication/screens/onboarding/widgets/SmoothPageIndicator.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatepageindicator,
            children: const [
              OnBoardingwidget(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingwidget(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingwidget(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // skipes btn
          const Positionedskip(),
          // Smooth Page Indicator
          const SmoothIndicatorWidget(),
          // Elevated Button widget
          const ElevatedButtonwidget()
        ],
      ),
    );
  }
}
