// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/screen_shot_service.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/button/circle_button_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/card_item_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_users_widget.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/controller/receipt_cubit.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/component/download_receipt_sheet.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';
import 'package:screenshot/screenshot.dart';

class TransactionReceiptPage extends StatelessWidget {
  const TransactionReceiptPage({
    super.key,
    required this.transactionTitle,
    this.withdrawIcon,
    this.fromWithdraw,
    required this.receiptModel,
  });

  final String transactionTitle;
  final ReceiptModel receiptModel;

  ///--------- withdraw
  final String? withdrawIcon;

  final bool? fromWithdraw;

  @override
  Widget build(BuildContext context) {
    log("${receiptModel.bankAccount?.accountNumber}");
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TransferCubit>.value(
          value: sl<TransferCubit>(),
        ),
        BlocProvider<TransactionAmountCubit>.value(
          value: sl<TransactionAmountCubit>(),
        ),
        BlocProvider<ReceiptCubit>(
          create: (BuildContext context) => ReceiptCubit(),
        )
      ],
      child: Builder(builder: (BuildContext context) {
        final ReceiptCubit receiptController = context.read<ReceiptCubit>();
        return MainScaffold(
          appBarWidget: AppBar(
            leading: IconButton(
              key: closeButtonKey,
              onPressed: () {
                CustomNavigator.instance
                    .pushReplacementNamed(RoutesName.authDashboard);
              },
              icon: const Icon(Icons.close),
            ),
            title: Text(
              tr(transactionTitle),
            ),
          ),
          scaffold: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //! transfer details
                Screenshot<Widget>(
                  controller: sl<ScreenShotService>().controller,
                  child: ContainerWithShadow(
                    margin: const EdgeInsets.only(
                      top: 24,
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        MyImage.svgAssets(
                          url: transactionTitle != "withdraw"
                              ? "assets/icons/transfer/success.svg"
                              : "assets/images/withdraw/withdraw_success.svg",
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: AutoSizeText(
                            '${tr(transactionTitle)} ${tr(transactionTitle != "withdraw" ? 'successfully' : "processing")}',
                            // card != null ? tr('deposit_successful') : tr("transfer_successful"),
                            style: headlineStyle.copyWith(
                              color: transactionTitle == "withdraw"
                                  ? AppColors.orange
                                  : AppColors.greenColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          "${receiptModel.amount} ${sl<TransactionAmountCubit>().currentCurrency?.iso3Code ?? tr("sar")}",
                          style: header5Style,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            bottom: 24,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              tr("operation_details"),
                              style: headlineStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (receiptModel.beneficiary != null)
                          TransferUsersWidget(
                            to: receiptModel.beneficiary!,
                          ),
                        if (receiptModel.cardModel != null)
                          CardItemWidget(
                            card: receiptModel.cardModel!,
                            hasRadio: false,
                          ),
                        if (fromWithdraw == true)
                          ListTile(
                            leading: MyImage.svgAssets(
                              url: withdrawIcon,
                              height: 24,
                              width: 24,
                            ),
                            title: Text(
                                receiptModel.bankAccount?.bankName ?? 'eee'),
                            subtitle: Text(
                                receiptModel.bankAccount?.accountNumber ??
                                    'ee'),
                          ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  tr("date"),
                                  style: smallStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat("MMMM dd ,yyyy").format(
                                    DateTime.now(),
                                  ),
                                  style: smallStyle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  tr("transaction_type"),
                                  style: smallStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: AutoSizeText(
                                  maxLines: 1,
                                  minFontSize: 8,
                                  //"International - Transfer",
                                  "$getType - ${tr(transactionTitle).capitalize()}",
                                  style: smallStyle,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 23,
                      bottom: 12,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      tr("share_e_receipt"),
                      style: smallStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                //! share box
                ContainerWithShadow(
                  margin: const EdgeInsets.only(
                    top: 24,
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: IntrinsicHeight(
                    child: Row(
                      children: <Widget>[
                        ReceiptShareWidget(
                          receiptModel: receiptModel,
                          name: 'pdf_file',
                          onTap: () async {
                            await receiptController.getReceipt("pdf",
                                receiptModel: receiptModel);
                          },
                        ),
                        VerticalDivider(
                          width: 1.5,
                          color: AppColors.greyColor,
                        ),
                        ReceiptShareWidget(
                          name: 'image_file',
                          onTap: () async {
                            await receiptController.getReceipt("jpg");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30, left: 20, right: 20, top: 20),
                  child: LoadingButton(
                    key: openDownloadReceiptSheetKey,
                    isLoading: false,
                    onTap: () {
                      DownloadReceiptSheet.instance
                          .show(context, receiptModel: receiptModel);
                    },
                    title: tr("download_receipt"),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String get getType => (receiptModel.beneficiary?.type == "external"
          ? tr("international")
          : tr("local"))
      .capitalize();
}

class ReceiptShareWidget extends StatelessWidget {
  const ReceiptShareWidget({
    super.key,
    this.receiptModel,
    required this.onTap,
    required this.name,
  });

  final ReceiptModel? receiptModel;
  final VoidCallback onTap;

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        key: getPdfButtonKey,
        onTap: onTap,
        child: Row(
          children: <Widget>[
            const Spacer(flex: 2),
            CircleIconButton(
              child: MyImage.svgAssets(
                url: "assets/icons/transfer/$name.svg",
                width: 32,
                height: 32,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              tr(name),
              style: smallStyle,
            ),
            const Spacer(
              flex: 10,
            )
          ],
        ),
      ),
    );
  }
}
