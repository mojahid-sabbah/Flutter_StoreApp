import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class success_secreen extends StatelessWidget {
  final String image, title, subTitle;
  final VoidCallback onPressed;
  const success_secreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage(image),
            width: THelperFunctions.screenWidth() * 0.6,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Text(subTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Get.to(() => onPressed);
                },
                child: const Text(TTexts.tContinue)),
          ),
        ],
    
      ),
    );
  }
}
