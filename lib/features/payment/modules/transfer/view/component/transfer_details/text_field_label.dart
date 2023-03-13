
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

Text buildLabel({required String label}) {
  return Text(tr(label),style: getStyle(size: 12,
      fontWeight: FontWeight.w600,
      fontFamily: "Plain")
  );
}
TextStyle getStyle({
  required double size,
  required FontWeight fontWeight,
  required String fontFamily
}){
  return TextStyle(
      color: AppColors.blackColor,fontSize: size,fontWeight: fontWeight
  );
}
