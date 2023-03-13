import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/page/transfer_receipt_page.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class TransferSuccessDialog {
  static final TransferSuccessDialog _instance =
      TransferSuccessDialog._internal();

  static TransferSuccessDialog get instance => _instance;

  TransferSuccessDialog._internal();

  Future<void> show(BuildContext context,
      {String type = "transfer", required ReceiptModel receiptModel}) async {
    log(receiptModel.toString());
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.secondaryColor,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: context.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyImage.svgAssets(
                    url: "assets/icons/transfer/success_transfer.svg",
                    width: 240,
                    height: 165,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: Text(
                      tr("transfer_successful"),
                      style: headlineStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    tr("payment_transfer_success"),
                    style: descriptionStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 12),
                    child: LoadingButton(
                      key: viewEReceiptKey,
                      isLoading: false,
                      onTap: () {
                        CustomNavigator.instance.pop();
                        CustomNavigator.instance.push(
                          routeWidget: TransactionReceiptPage(
                            // card: receiptModel?.cardModel,
                            // to: receiptModel?.beneficiary,
                            // amount: sl<TransactionAmountCubit>().amount.toString(),

                            transactionTitle: 'transfer',
                            receiptModel: receiptModel,
                          ),
                        );
                      },
                      title: tr("view_e_receipt"),
                    ),
                  ),
                  TextButton(
                    key: cancelButtonDialogKey,
                    onPressed: () {
                      CustomNavigator.instance.pop();
                      CustomNavigator.instance
                          .pushReplacementNamed(RoutesName.authDashboard);
                    },
                    child: Text(
                      tr("back_to_home"),
                      style: paragraphStyle.copyWith(
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
