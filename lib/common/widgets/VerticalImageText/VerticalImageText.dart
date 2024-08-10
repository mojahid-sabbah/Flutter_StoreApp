import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class VerticalImageText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetWorkImage;

  const VerticalImageText({
    super.key,
    this.isNetWorkImage = true,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.onTap,
    this.backgroundColor = TColors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Home page >>> Categories Icons ROW --- O O O O ---------------

    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
          child: Column(
            children: [
              //----------------
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                    color: (dark ? TColors.dark : TColors.white),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Image(
                    image: isNetWorkImage
                        ? NetworkImage(image)
                        : AssetImage(image) as ImageProvider,
                    fit: BoxFit.cover,
                    color: dark ? TColors.light : TColors.dark,
                  ),
                ),
              ),
              //-----------------------
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              //----------------------
              SizedBox(
                width: 58,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ));
  }
}
