import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CircularContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final Color borderColor;

  const CircularContainer({
    super.key,
    this.width ,
    this.height ,
    this.padding,
    this.child,
    this.margin,
    this.backgroundColor = TColors.white,
    this.radius = TSizes.cardRadiusLg,
    this.showBorder = false,
    this.borderColor = TColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
