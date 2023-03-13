import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/controller/bill_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/view/component/bill_item.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/page/transfer_receipt_page.dart';

class BillSummery extends StatelessWidget {
  const BillSummery({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MainScaffold(
      scaffold: BlocProvider<BillCubit>.value(
        value: sl<BillCubit>(),
        child: BlocConsumer<BillCubit, BillState>(
          listener: (BuildContext context, BillState state) {
            if (state is PayBillErrorState) {
              MyToast(state.failure.message);
            }
          },
          builder: (BuildContext context, BillState state) {
            final BillCubit controller = context.read<BillCubit>();
            return Scaffold(
                appBar: MainAppBar(
                  title: tr('pay_bill'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tr('detail_bill'),
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontFamily: 'Bold',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                BillItem(
                                  title: 'Company',
                                  value: controller
                                      .billSummary.bill!.billDetail!.company,
                                ),
                                const Divider(
                                  thickness: 0.2,
                                ),
                                BillItem(
                                  title: 'Customer Name',
                                  value: controller.billSummary.bill!
                                      .billDetail!.customerName,
                                ),
                                const Divider(
                                  thickness: 0.2,
                                ),
                                BillItem(
                                  title: 'Customer id',
                                  value: controller
                                      .billSummary.bill!.billDetail!.customerId,
                                ),
                                const Divider(
                                  thickness: 0.2,
                                ),
                                BillItem(
                                  title: 'Period',
                                  value: controller.billSummary.bill!
                                      .billDetail!.billingPeriod,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            tr('total'),
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontFamily: 'Bold',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Column(
                            children: <Widget>[
                              BillItem(
                                title: 'Total Bill',
                                value: controller
                                    .billSummary.bill!.total!.totalBill,
                              ),
                              const Divider(
                                thickness: 0.2,
                              ),
                              BillItem(
                                title: 'Bill',
                                value: controller.billSummary.bill!.total!.bill,
                              ),
                              const Divider(
                                thickness: 0.2,
                              ),
                              BillItem(
                                title: 'Fee',
                                value: controller.billSummary.bill!.total!.fee,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(24),
                  child: LoadingButton(
                    key: payNowKey,
                    isLoading: false,
                    title: tr('pay_now'),
                    onTap: () async {
                      await _payBill(
                        controller,
                        context,
                        size,
                      );
                    },
                  ),
                ));
          },
        ),
      ),
    );
  }

  Future<void> _payBill(
      BillCubit controller, BuildContext context, Size size) async {
    final ReceiptModel? result = await controller.payBill();
    if (result != null) {
      await CustomSuccessDialog.instance.show(
        context: context,
        canClose: true,
        title: tr('bill_paid_successfully'),
        subTitle: tr('payment_transfer_successfully'),
        onPressedFirstButton: () {
          CustomNavigator.instance.pop();
          CustomNavigator.instance.push(
            routeWidget: TransactionReceiptPage(
              transactionTitle: "pay_bill",
              receiptModel: result,
            ),
          );
        },
        imageUrl: 'assets/images/home/guestDialog.svg',
        firstButtonText: tr('View E-Receipt'),
      );
    }
  }
}
