import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/curvedEdges/curved_edges.dart';

class ClipPathWidget extends StatelessWidget {
  const ClipPathWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // this to made a curved widget
    return ClipPath(
      clipper: CustemCurvedEdgs(),
       child: child);
  }
}
