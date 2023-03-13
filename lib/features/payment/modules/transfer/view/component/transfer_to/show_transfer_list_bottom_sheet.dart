import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/transfer_list_bottom_sheet.dart';

Future<dynamic> buildTransferListBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        constraints: BoxConstraints(maxHeight: context.height * 0.8),
        child: const TransferListBottomSheet()),
  );
}
