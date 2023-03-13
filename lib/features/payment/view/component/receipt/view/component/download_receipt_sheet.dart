import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/circle_button_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/controller/receipt_cubit.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class DownloadReceiptSheet {
  static final DownloadReceiptSheet _instance =
      DownloadReceiptSheet._internal();
  static DownloadReceiptSheet get instance => _instance;

  DownloadReceiptSheet._internal();
  void show(BuildContext context, {ReceiptModel? receiptModel}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (BuildContext context) {
        return BlocProvider<ReceiptCubit>(
          create: (BuildContext context) => ReceiptCubit(),
          child: Builder(builder: (BuildContext context) {
            final ReceiptCubit receiptController = context.read<ReceiptCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: Text(
                      tr("download_e_receipt"),
                      style: headlineStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleIconButton(
                            key: getPdfButtonKey,
                            child: MyImage.svgAssets(
                              url: "assets/icons/transfer/pdf_receipt.svg",
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () async {
                              await receiptController.getReceipt(
                                'pdf',
                                save: true,
                                receiptModel: receiptModel,
                              );
                              CustomNavigator.instance.pop();

                              MyToast(tr("receipt downloaded"),
                                  background: AppColors.greenColor);
                            },
                          ),
                          Text(tr("pdf_file"))
                        ],
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Column(
                        children: <Widget>[
                          CircleIconButton(
                            color: Colors.transparent,
                            key: getImageButtonKey,
                            child: MyImage.svgAssets(
                              url: "assets/icons/transfer/image_receipt.svg",
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () {
                              receiptController.getReceipt("jpg", save: true);
                              CustomNavigator.instance.pop();

                              MyToast(tr("receipt downloaded"),
                                  background: AppColors.greenColor);
                            },
                          ),
                          Text(tr("image_file"))
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
