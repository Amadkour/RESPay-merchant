import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class PercentageIndicator extends StatelessWidget {
  final double percentage;

  const PercentageIndicator({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 25.0,
      animation: true,
      lineWidth: 9.0,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percentage / 100,
      backgroundColor: AppColors.darkColor.withOpacity(0.07),
      center: AutoSizeText(
        "${percentage.toStringAsFixed(0)}%",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      progressColor: AppColors.greenColor,
    );
  }
}
