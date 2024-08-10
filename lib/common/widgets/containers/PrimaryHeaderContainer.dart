import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/curvedEdges/ClipPathWidget.dart';
import 'package:t_store/utils/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
      // ClipPathWidget >> this to made a curved widget
    return ClipPathWidget(
      child: Container(
        color: TColors.primary,
        child: Stack(
          children: [
             Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
            // Positioned(
            //    bottom: 50 ,
            //    child: Text("       TEST"))
          ],
        ),
      ),
    );
  }
}
