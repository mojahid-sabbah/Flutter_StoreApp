import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

// ignore: must_be_immutable
class TFormDivider extends StatelessWidget {
  String dividerText;
  TFormDivider({super.key, required this.dark, required this.dividerText});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.grey,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.grey,
          indent: 5,
          endIndent: 60,
        )),
      ],
    );
  }
}
