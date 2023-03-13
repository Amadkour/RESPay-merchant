import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget({
    super.key,
    required this.color,
    required this.icon,
    this.slug,
  });
  final Color color;
  final String icon;
  final String? slug;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: MyImage.svgAssets(
        url: icon,
        width: 40,
        height: 40,
        borderRadius: 40,
      ),
    );
  }
}
