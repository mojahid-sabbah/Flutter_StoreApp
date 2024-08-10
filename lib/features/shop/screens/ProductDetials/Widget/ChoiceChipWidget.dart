import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ChoiceChipWidget extends StatelessWidget {
  const ChoiceChipWidget({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;
    return ChoiceChip(
      label: isColor
          ? const SizedBox()
          :   Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: selected ? TColors.white : null,
      ),
      avatar: isColor
          ? CircularContainer(
              width: 50,
              height: 50,
              backgroundColor: THelperFunctions.getColor(text)!,
            )
          : null,
      labelPadding:isColor? const EdgeInsets.all(0):null,
      shape:isColor? const CircleBorder():null,
      padding:isColor? const EdgeInsets.all(0):null,
      selectedColor: Colors.green,
      backgroundColor:isColor?THelperFunctions.getColor(text)!:null,
    );
  }
}
