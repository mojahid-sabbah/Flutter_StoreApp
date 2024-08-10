import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class ShadowStyle {
  static final VerticalproductCard = BoxShadow(
      color: TColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final HorezantalproductCard = BoxShadow(
      color: TColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));



}
