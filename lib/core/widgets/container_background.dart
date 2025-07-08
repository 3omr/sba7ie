import 'package:flutter/widgets.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';

class ContainerBackground extends StatelessWidget {
  final Widget child;
  const ContainerBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManagement.lightGrey.withOpacity(0.9),
            ColorManagement.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
