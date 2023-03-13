import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class BadgeWidgetIcon extends StatelessWidget {
  const BadgeWidgetIcon({super.key, required this.icon, required this.number});

  final int number;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return badge.Badge(
      showBadge: number != 0,
      position: badge.BadgePosition.topEnd(top: -10, end: -6),
      badgeStyle: badge.BadgeStyle(badgeColor: AppColors.blackColor),
      badgeContent: Text(number.toString(),
          style: const TextStyle(
              fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
      child: SvgPicture.asset(
        width: 20,
        height: 20,
        color: AppColors.blackColor,
        icon,
      ),
    );
  }
}
