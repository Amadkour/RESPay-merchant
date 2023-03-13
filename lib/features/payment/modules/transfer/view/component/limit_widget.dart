import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/checked_widget.dart';

class LimitWidget extends StatelessWidget {
  const LimitWidget({
    super.key,
    required this.title,
    this.exceeded = false,
  });
  final String title;
  final bool exceeded;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CheckWidget(
          isChecked: exceeded,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AutoSizeText(
            title,
            maxLines: 1,
            minFontSize: 8,
            style: descriptionStyle,
          ),
        )
      ],
    );
  }
}
