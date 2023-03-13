import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/notes_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/beneficiary_item.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/page/transfer_receipt_page.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class SendGiftRequest extends StatefulWidget {
  final Beneficiary beneficiary;
  final String? dialogTitle;
  final String? dialogSubTitle;

  const SendGiftRequest(
      {super.key,
      required this.beneficiary,
      required this.dialogTitle,
      required this.dialogSubTitle});

  @override
  State<SendGiftRequest> createState() => _SendGiftRequestState();
}

class _SendGiftRequestState extends State<SendGiftRequest> {
  @override
  void initState() {
    super.initState();
    sl<TransferOptionsCubit>().reset();
  }

  GlobalKey<FormState> sendGiftValidationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiftCubit>.value(
        value: sl<GiftCubit>()..resetSendMoneyData(),
        child: BlocBuilder<GiftCubit, GiftState>(
          builder: (BuildContext context, GiftState state) {
            return MainScaffold(
                appBarWidget: MainAppBar(
                    backgroundColor: AppColors.lightWhite, title: "send_gift"),
                scaffold: BlocBuilder<GiftCubit, GiftState>(
                  builder: (BuildContext context, GiftState state) {
                    if (state is GiftSendSate) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        CustomSuccessDialog.instance.show(
                          title: tr(widget.dialogTitle!),
                          subTitle: tr(widget.dialogSubTitle!),
                          context: context,
                          onPressedFirstButton: () {
                            CustomNavigator.instance.pop();
                            CustomNavigator.instance.push(
                              routeWidget: TransactionReceiptPage(
                                  transactionTitle: "Gift",
                                  receiptModel: state.receiptModel.copyWith(
                                    beneficiary: widget.beneficiary,
                                  )),
                            );
                          },
                          onPressedSecondButton: () {
                            CustomNavigator.instance.popUntil(
                                (Route<dynamic> route) =>
                                    route.settings.name ==
                                    RoutesName.authDashboard);
                          },
                        );
                        sl<GiftCubit>().resetStateAfterNavigate();
                      });
                    }
                    return SingleChildScrollView(
                      child: ColoredBox(
                        color: AppColors.lightWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  BlocProvider<BeneficiaryCubit>.value(
                                    value: sl<BeneficiaryCubit>(),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      width: double.infinity,
                                      height: 70,
                                      child: BlocBuilder<BeneficiaryCubit,
                                          BeneficiaryState>(
                                        builder: (BuildContext context,
                                                BeneficiaryState state) =>
                                            BeneficiaryItem(
                                          verticalPadding: 12,
                                          imageRadius: 23,
                                          beneficiary: widget.beneficiary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
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
                                    bottom: 50,
                                  ),
                                  child: Form(
                                    key: sendGiftValidationFormKey,
                                    child: Column(
                                      children: <Widget>[
                                        TransactionAmountTextField(
                                          isLocal: true,
                                          key: transactionAmountTextFieldKey,
                                          onChanged: (String v) {
                                            sl<GiftCubit>().updateState();
                                          },
                                          controller:
                                              sl<GiftCubit>().amountController,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        BlocProvider<
                                            TransferOptionsCubit>.value(
                                          value: sl<TransferOptionsCubit>(),
                                          child: BlocBuilder<
                                              TransferOptionsCubit,
                                              TransferOptionsState>(
                                            builder: (BuildContext context,
                                                TransferOptionsState state) {
                                              if (state
                                                  is TransferOptionsLoadingState) {
                                                return const NativeLoading();
                                              } else {
                                                return BlocProvider<
                                                    GiftCubit>.value(
                                                  value: sl<GiftCubit>(),
                                                  child: BlocBuilder<GiftCubit,
                                                      GiftState>(
                                                    builder: (BuildContext
                                                                context,
                                                            GiftState state) =>
                                                        CustomDropdown<
                                                            TransferCategoryModel>(
                                                      key:
                                                          categoriesDropDownListKey,
                                                      items:
                                                          sl<TransferOptionsCubit>()
                                                              .categories,
                                                      itemToString:
                                                          (TransferCategoryModel
                                                                  category) =>
                                                              category.name ??
                                                              "",
                                                      value: sl<GiftCubit>()
                                                          .currentCategory,
                                                      onChanged:
                                                          (TransferCategoryModel?
                                                              v) {
                                                        sl<GiftCubit>()
                                                            .setCurrentCategory(
                                                                v!);
                                                      },
                                                      label: "select_category",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        BlocProvider<
                                            TransferOptionsCubit>.value(
                                          value: sl<TransferOptionsCubit>(),
                                          child: BlocBuilder<
                                              TransferOptionsCubit,
                                              TransferOptionsState>(
                                            builder: (BuildContext context,
                                                TransferOptionsState state) {
                                              final TransferOptionsCubit
                                                  optionsController =
                                                  context.read<
                                                      TransferOptionsCubit>();
                                              return CustomDropdown<String>(
                                                key: purposeDropDownListKey,
                                                items: optionsController
                                                        .transferOptions
                                                        ?.transferPurposes ??
                                                    <String>[],
                                                itemToString:
                                                    (String purpose) => purpose,
                                                value: sl<GiftCubit>()
                                                    .currentPurpose,
                                                onChanged: (String? value) {
                                                  sl<GiftCubit>()
                                                      .setCurrentPurpose(
                                                          value!);
                                                },
                                                label: "purpose",
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        NotesTextfield(
                                          key: noteTextFieldKey,
                                          noteController:
                                              sl<GiftCubit>().noteController,
                                          onChanged: (String v) {
                                            sl<GiftCubit>().updateState();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                bottomNavigationBar: SafeArea(
                    minimum: const EdgeInsets.all(12.0),
                    child: LoadingButton(
                      key: sendGiftContinueButtonKey,
                      isLoading: state is SendGiftLoadingState,
                      topPadding: 10,
                      enable: sl<GiftCubit>()
                          .giftAmountRequestButton(sendGiftValidationFormKey),
                      onTap: () {
                        sl<GiftCubit>().sendGift(widget.beneficiary.uuid!);
                      },
                      title: tr('continue'),
                    )));
          },
        ));
  }
}
