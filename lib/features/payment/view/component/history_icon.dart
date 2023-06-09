import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class HistoryIconWidget extends StatelessWidget {
  const HistoryIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(bottom: 13,top: 13),
      child: InkWell(onTap: () {
        CustomNavigator.instance.pushNamed(RoutesName.transferHistory);
      },child: SvgPicture.asset("assets/icons/transfer/timer.svg")),
    );
  }
}
