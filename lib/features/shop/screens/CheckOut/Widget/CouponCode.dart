import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      backgroundColor:
          THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
          top: TSizes.sm, bottom: TSizes.sm, right: TSizes.sm, left: TSizes.md),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Have a promo code ? Enter here ',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          )),
          SizedBox(
            width: 80,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.white.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.5),
                    backgroundColor: TColors.grey.withOpacity(0.5),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1))),
                child: const Text('Apply')),
          )
        ],
      ),
    );
  }
}
