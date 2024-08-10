import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class GridProductsLayout extends StatelessWidget {
  const GridProductsLayout({
    super.key,
    required this.itemCount,
    required this.ItemBuilder,
    this.mainAxisExtent = 288,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) ItemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap:
          true, // *** Very Important*** without this line will return an error and doesnt appear on screen
      padding: EdgeInsets.zero,
      physics:
          const NeverScrollableScrollPhysics(), // this line is allow to scroll on  (   GridView) WIDGET
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: ItemBuilder,
    );
  }
}
