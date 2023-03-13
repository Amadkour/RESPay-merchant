import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/notes_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/beneficiary_item.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/page/transfer_receipt_page.dart';

class RequestAmountPage extends StatefulWidget {
  final Beneficiary? beneficiary;
  final String? dialogTitle;
  final String? dialogSubTitle;
  const RequestAmountPage(
      {super.key,
      required this.beneficiary,
      required this.dialogTitle,
      required this.dialogSubTitle});

  @override
  State<RequestAmountPage> createState() => _RequestAmountPageState();
}

class _RequestAmountPageState extends State<RequestAmountPage> {
  final GlobalKey<FormState> requestMoneyValidationFormKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (sl<RequestCubit>().moneyRequestsModel.categories!.isEmpty) {
      sl<RequestCubit>()
        ..resetRequestAmount()
        ..getMoneyRequests();
    } else {
      sl<RequestCubit>().resetRequestAmount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCubit>.value(
      value: sl<RequestCubit>(),
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (BuildContext context, RequestState state) {
          return MainScaffold(
            appBarWidget: MainAppBar(
                backgroundColor: AppColors.lightWhite, title: "request_money"),
            scaffold: BlocProvider<RequestCubit>.value(
              value: sl<RequestCubit>(),
              child: BlocBuilder<RequestCubit, RequestState>(
                builder: (BuildContext context, RequestState state) {
                  if (state is RequestLoadingState) {
                    return const NativeLoading();
                  }
                  if (state is RequestMoneyErrorState) {
                    return Container();
                  }
                  if (state is RequestSendSate) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomSuccessDialog.instance.show(
                        title: tr(widget.dialogTitle!),
                        subTitle: tr(widget.dialogSubTitle!),
                        context: globalKey.currentContext,
                        onPressedFirstButton: () {
                          CustomNavigator.instance.pop();
                          CustomNavigator.instance.push(
                            routeWidget: TransactionReceiptPage(
                              transactionTitle: "Request",
                              receiptModel: state.receipt
                                  .copyWith(beneficiary: widget.beneficiary),
                            ),
                          );
                        },
                      );
                    });
                    sl<RequestCubit>().resetStateAfterNavigate();
                  }
                  return SingleChildScrollView(
                    child: Container(
                      color: AppColors.lightWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                width: double.infinity,
                                height: 70,
                                child: BlocProvider<BeneficiaryCubit>.value(
                                  value: sl<BeneficiaryCubit>(),
                                  child: BlocBuilder<BeneficiaryCubit,
                                      BeneficiaryState>(
                                    builder: (BuildContext context,
                                        BeneficiaryState state) {
                                      return BeneficiaryItem(
                                        imageRadius: 23,
                                        verticalPadding: 12,
                                        beneficiary: widget.beneficiary!,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 24, bottom: 20),
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 9,
                                bottom: 26,
                              ),
                              child: Form(
                                  key: requestMoneyValidationFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      TransactionAmountTextField(
                                        isLocal: true,
                                        key: transactionAmountTextFieldKey,
                                        onChanged: (String v) {
                                          sl<RequestCubit>().updateState();
                                        },
                                        controller:
                                            sl<RequestCubit>().amountController,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      CustomDropdown<String>(
                                        key: categoriesDropDownListKey,
                                        items: sl<RequestCubit>()
                                            .moneyRequestsModel
                                            .categories!,
                                        itemToString: (String category) =>
                                            category,
                                        value:
                                            sl<RequestCubit>().currentCategory,
                                        onChanged: (String? v) {
                                          sl<RequestCubit>()
                                              .setCurrentCategory(v!);
                                        },
                                        label: "select_category",
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      NotesTextfield(
                                        key: noteTextFieldKey,
                                        noteController:
                                            sl<RequestCubit>().noteController,
                                        onChanged: (String v) {
                                          sl<RequestCubit>().updateState();
                                        },
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(12.0),
              child: LoadingButton(
                key: requestAmountContinueButtonKey,
                topPadding: 10,
                enable: sl<RequestCubit>()
                    .requestAmountButton(requestMoneyValidationFormKey),
                isLoading: state is RequestSendLoadingState,
                onTap: () {
                  sl<RequestCubit>()
                      .sendRequestMoney(widget.beneficiary!.uuid!);
                },
                title: tr('continue'),
              ),
            ),
          );
        },
      ),
    );
  }
}
