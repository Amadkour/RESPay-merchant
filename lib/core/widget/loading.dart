import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class NativeLoading2 extends StatefulWidget {
  @override
  _NativeLoadingState createState() => _NativeLoadingState();
}

class _NativeLoadingState extends State<NativeLoading2>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: animationController
            .drive(ColorTween(begin: AppColors.greenColor, end: Colors.red)),
      ),
    );
  }
}

class NativeLoading extends StatelessWidget {
  final double size;

  const NativeLoading({this.size = 50.0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        key: loadingKey,
        child: LoadingAnimationWidget.fourRotatingDots(
          color: AppColors.greenColor,
          size: size,
        ),
      ),
    );
  }
}
