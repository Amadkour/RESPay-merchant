import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key, required this.title, required this.value});
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(tr(title),
                style:
                    context.theme.textTheme.subtitle1!.copyWith(fontSize: 15)),
            const Expanded(child: SizedBox()),
            Expanded(
              child: AutoSizeText(
                tr(value!),
                textAlign: TextAlign.end,
                maxLines: 1,
                minFontSize: 7,
                maxFontSize: 15,
                style: context.theme.textTheme.subtitle1!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
