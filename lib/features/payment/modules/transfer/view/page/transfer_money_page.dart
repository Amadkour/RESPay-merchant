import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/notes_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/conversion_rate_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/limit_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/beneficiary_item.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage(
      {super.key, required this.beneficiary, this.dropDownsList});
  final Beneficiary beneficiary;
  final Widget? dropDownsList;

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      sl<TransferCubit>().reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TransferCubit>.value(
          value: sl<TransferCubit>(),
        ),
        BlocProvider<TransferOptionsCubit>.value(
          value: sl<TransferOptionsCubit>(),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        final TransferCubit transferCubit = context.read<TransferCubit>();
        final TransferOptionsCubit optionsController =
            context.read<TransferOptionsCubit>();
        return MainScaffold(
          appBarWidget: MainAppBar(
            title: tr("transfer_money"),
          ),
          scaffold: BlocProvider<BeneficiaryCubit>.value(
            value: sl<BeneficiaryCubit>(),
            child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
              builder: (BuildContext context, BeneficiaryState state) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (widget.beneficiary.type == "internal")
                        ContainerWithShadow(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: BeneficiaryItem(
                            verticalPadding: 12,
                            imageRadius: 23,
                            boolShowType: true,
                            beneficiary: widget.beneficiary,
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 24,
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
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
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 46),
                                child: TransactionAmountTextField(
                                  isLocal:
                                      widget.beneficiary.type == "internal",
                                  key: transactionAmountTextFieldKey,
                                  textAlign: TextAlign.center,
                                  controller: transferCubit.amountController,
                                ),
                              ),
                              if (widget.beneficiary.type ==
                                  "internal") ...<Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child:
                                      Text.rich(TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: sl<TransactionHistoryCubit>()
                                              .wallet
                                              ?.total
                                              ?.toStringAsFixed(2) ??
                                          "0",
                                      style: smallStyle.copyWith(
                                        color: AppColors.greenColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " ${tr("sar")}",
                                      style: smallStyle.copyWith(
                                        color: AppColors.greenColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: Text(
                                    tr("available_balance"),
                                    style: smallStyle.copyWith(
                                      fontSize: 10,
                                      color: AppColors.descriptionColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                BlocBuilder<TransferOptionsCubit,
                                    TransferOptionsState>(
                                  builder: (BuildContext context,
                                      TransferOptionsState state) {
                                    return CustomDropdown<
                                        TransferCategoryModel>(
                                      key: categoriesDropDownListKey,
                                      items: optionsController.categories,
                                      itemToString:
                                          (TransferCategoryModel category) =>
                                              category.name ?? "",
                                      value: optionsController.categories
                                          .firstWhereOrNull(
                                        (TransferCategoryModel element) =>
                                            element ==
                                            context
                                                .watch<TransferCubit>()
                                                .category,
                                      ),
                                      onChanged: (TransferCategoryModel? v) {
                                        transferCubit.changeCategory(v!);
                                      },
                                      label: "select_category",
                                    );
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: BlocBuilder<TransferOptionsCubit,
                                      TransferOptionsState>(
                                    builder: (BuildContext context,
                                        TransferOptionsState state) {
                                      return CustomDropdown<String>(
                                        key: purposeDropDownListKey,
                                        items: optionsController.transferOptions
                                                ?.transferPurposes ??
                                            <String>[],
                                        itemToString: (String purpose) =>
                                            purpose,
                                        value: context
                                            .watch<TransferCubit>()
                                            .purpose,
                                        onChanged: (String? v) {
                                          transferCubit.changePurpose(v);
                                        },
                                        label: "purpose",
                                      );
                                    },
                                  ),
                                ),
                                NotesTextfield(
                                  key: noteTextFieldKey,
                                  onChanged: (String v) {
                                    transferCubit.onNoteChange(v);
                                  },
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (widget.beneficiary.type == "external")
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              LimitWidget(
                                title: tr(
                                    "Remaining daily transfer limit 50,000.00 SAR"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 35,
                                ),
                                child: LimitWidget(
                                  title: tr(
                                      "Remaining international transfer limit 50,000.00 SAR"),
                                ),
                              ),
                              //! conversion rate widget
                              const ConversionRateWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 12),
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    tr("details"),
                                    style: paragraphStyle,
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: BlocBuilder<TransferOptionsCubit,
                                    TransferOptionsState>(
                                  builder: (BuildContext context,
                                      TransferOptionsState state) {
                                    final TransferOptionsCubit
                                        optionsController =
                                        context.read<TransferOptionsCubit>();
                                    return CustomDropdown<String>(
                                      key: purposeDropDownListKey,
                                      color: Colors.white,
                                      items: optionsController.transferOptions
                                              ?.transferPurposes ??
                                          <String>[],
                                      itemToString: (String purpose) => purpose,
                                      value: context
                                          .watch<TransferCubit>()
                                          .purpose,
                                      onChanged: (String? v) {
                                        transferCubit.changePurpose(v);
                                      },
                                      label: "purpose",
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 56,
                            left: 28,
                            right: 28,
                            bottom: 30,
                          ),
                          child: BlocBuilder<TransferCubit, TransferState>(
                            builder:
                                (BuildContext context, TransferState state) =>
                                    LoadingButton(
                              key: makeTransferContinueButtonKey,
                              isLoading: false,
                              topPadding: 0,
                              enable: transferCubit.makeTransferButtonEnable(
                                  isInternal:
                                      widget.beneficiary.type == "internal"),
                              onTap: () {
                                CustomNavigator.instance.pushNamed(
                                    RoutesName.newTransferSummary,
                                    arguments: widget.beneficiary);
                              },
                              title: tr('continue'),
                            ),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
