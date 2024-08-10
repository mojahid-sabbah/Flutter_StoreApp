import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/Signup/Controllers/SignUpControllers.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class Terms_checkBox extends StatelessWidget {
  const Terms_checkBox({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignUpControllers.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: ((value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value),
            ),
          ),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: '${TTexts.iAgreeTo} ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: TTexts.privacyPolicy,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
          ),
          TextSpan(
            text: ' ${TTexts.and} ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: TTexts.termsOfUse,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
          ),
        ]))
      ],
    );
  }
}
