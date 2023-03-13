import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/summary_bottom_sheet_body.dart';

Future<dynamic> summaryBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,

    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
          child: const SummaryBody()
      );
    },
  );
}
