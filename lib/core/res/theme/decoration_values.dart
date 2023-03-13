import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

const double _defaultBorderRadius = 10;
const Radius defaultRadius = Radius.circular(_defaultBorderRadius);
final BorderRadius defaultBorderRadius =
    BorderRadius.circular(_defaultBorderRadius);

final BoxShadow defaultShadow = BoxShadow(
  spreadRadius: 5,
  blurRadius: 5,
  color: AppColors.shadow.withOpacity(0.3),
);
