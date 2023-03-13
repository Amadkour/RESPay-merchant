// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/res/utils/screen_shot_service.dart';
import 'package:res_pay_merchant/core/res/utils/share_service.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/button/circle_button_widget.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/card_item_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_users_widget.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/component/download_receipt_sheet.dart';
import 'package:screenshot/screenshot.dart';

class QRTransactionReceiptPage extends StatelessWidget {
  const QRTransactionReceiptPage({
    super.key,
    this.to,
    this.card,
    this.transactionTitle,
    this.transactionType = "transfer",
    this.from,
  });
  final Beneficiary? to;
  final dynamic from;
  final String transactionType;
  final String? transactionTitle;
  final CreditCardModel? card;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TransferCubit>.value(
          value: sl<TransferCubit>(),
        ),
        BlocProvider<TransactionAmountCubit>.value(
          value: sl<TransactionAmountCubit>(),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        return MainScaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: LoadingButton(
              onTap: () {
                DownloadReceiptSheet.instance.show(context);
              },
              title: tr("download_receipt"),
              isLoading: false,
              topPadding: 0,
            ),
          ),
          appBarWidget: AppBar(
            leading: Center(
              child: IconButton(
                onPressed: () {
                  CustomNavigator.instance.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            title: SizedBox(
              width: context.width * 0.7,
              child: Center(
                child: Text(
                  transactionTitle ?? tr(transactionType),
                ),
              ),
            ),
          ),
          scaffold: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //! transfer details
                Screenshot<dynamic>(
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
                        SvgPicture.asset("assets/icons/transfer/success.svg"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: AutoSizeText(
                            'Gift Sent!',
                            style: headlineStyle.copyWith(
                              color: AppColors.greenColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        BlocProvider<TransactionAmountCubit>.value(
                          value: sl<TransactionAmountCubit>(),
                          child: Builder(builder: (BuildContext context) {
                            final TransactionAmountCubit amountCubit =
                                context.read<TransactionAmountCubit>();
                            return Text(
                              "182.00 ${amountCubit.currentCurrency?.iso3Code ?? tr("sar")}",
                              style: header5Style,
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            bottom: 24,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              tr("detail_transaction"),
                              style: headlineStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (to != null)
                          TransferUsersWidget(
                            to: to!,
                          ),
                        if (card != null)
                          CardItemWidget(
                            card: card!,
                            hasRadio: false,
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
                                  'Purpose',
                                  style: smallStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  'QR Pay',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
                  child: IntrinsicHeight(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleIconButton(
                                child: MyImage.svgAssets(
                                  url: "assets/icons/transfer/pdf_receipt.svg",
                                  width: 20,
                                  height: 20,
                                ),
                                onPressed: () async {
                                  await _getReceipt("pdf");
                                },
                              ),
                              Text(
                                tr("pdf_file"),
                                style: smallStyle,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: VerticalDivider(
                            width: 1.5,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleIconButton(
                                child: MyImage.svgAssets(
                                  url:
                                      "assets/icons/transfer/image_receipt.svg",
                                  width: 20,
                                  height: 20,
                                ),
                                onPressed: () async {
                                  _getReceipt("jpg");
                                },
                              ),
                              Text(
                                tr("image_file"),
                                style: smallStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _getReceipt(String fileExt) async {
    final Uint8List? path =
        await sl<ScreenShotService>().convertToBytes(fileExt);
    if (path != null) {
      sl<ShareService>().shareFile(path, fileExt);
    }
  }
}
