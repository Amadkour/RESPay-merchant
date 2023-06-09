import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ComingSoon extends StatelessWidget {
  final String? message;
  final bool showMessage;
  final double? height;

  const ComingSoon({this.message, this.showMessage = true, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: (height ?? 200) / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FaIcon(FontAwesomeIcons.bullhorn),
            const SizedBox(
              height: 15,
            ),
            Text(
              message ?? tr('coming_soon'),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Bold',
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
