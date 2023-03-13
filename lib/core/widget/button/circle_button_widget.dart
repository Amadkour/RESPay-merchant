import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
  });
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 40,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressed,
      highlightElevation: 0,
      shape: const CircleBorder(),
      color: color ?? AppColors.pointButtonColor.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
