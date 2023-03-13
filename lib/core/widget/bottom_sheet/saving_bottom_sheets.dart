import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/amount_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/saving_role_text_field.dart';
import 'package:res_pay_merchant/features/authentication/view/component/auth_common_title.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';

class SavingBottomSheet {
  SavingBottomSheet({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String blackButtonText,
    required double availableBalance,
    int? index,
    int? to,
    int? from,
    int? save,
    bool isTextFieldSection = true,
  }) {
    bool flag = false;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bottomSheetContext) {
        return BlocProvider<SavingCubit>.value(
          value: sl<SavingCubit>(),
          child: BlocBuilder<SavingCubit, SavingState>(
            builder: (BuildContext context, SavingState state) {
              final SavingCubit cubit = BlocProvider.of(context);
              if (to != null && !flag) {
                cubit.fillTextFieldWhileUpdateRole(
                    to: to, from: from!, save: save!);
                flag = true;
              }
              return Directionality(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: (isTextFieldSection
                            ? context.height * 0.8
                            : context.height * 0.7) +
                        MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 25,
                        bottom: 15 +
                            MediaQuery.of(bottomSheetContext)
                                .viewInsets
                                .bottom),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: KeyboardActionsWidget(
                      focusNodeModels: <FocusNodeModel>[
                        FocusNodeModel(focusNode: cubit.fromFocusNode),
                        FocusNodeModel(focusNode: cubit.toFocusNode),
                        FocusNodeModel(focusNode: cubit.saveFocusNode),
                      ],
                      child: SingleChildScrollView(
                        key: savingBottomSheetListKey,
                        child: SizedBox(
                          height: (isTextFieldSection
                                  ? context.height * 0.8
                                  : context.height * 0.7) +
                              MediaQuery.of(bottomSheetContext)
                                  .viewInsets
                                  .bottom,
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: context.width * 0.2,
                                    color: AppColors.bottomSheetIconColor,
                                    height: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                StartupTexts(title: title, subTitle: subTitle),
                                Center(
                                  child: isTextFieldSection
                                      ? _TextFieldSectionBottomSheet(
                                          availableBalance: availableBalance,
                                          amountController:
                                              cubit.amountController,
                                          cubit: cubit,
                                        )
                                      : _AddRoleSectionBottomSheet(
                                          fromController: cubit.fromController,
                                          toController: cubit.toController,
                                          saveController: cubit.saveController,
                                          cubit: cubit,
                                        ),
                                ),
                                const Spacer(),
                                Center(
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    return LoadingButton(
                                      key: savingLoadingButtonKey,
                                      topPadding: 0,
                                      isLoading: state
                                              is SavingButtonLoadingState ||
                                          state is SavingAddNewRoleLoading ||
                                          state is SavingUpdateRoleLoading,
                                      enable:
                                          cubit.enableButtonSheetButton(title),
                                      title: blackButtonText,
                                      onTap: () async {
                                        await cubit.submitBottomSheet(
                                            title, index);
                                      },
                                    );
                                  }),
                                ),
                                LoadingButton(
                                  isLoading: false,
                                  topPadding: 0,
                                  title: tr('cancel'),
                                  backgroundColor: Colors.white,
                                  fontColor: AppColors.blackColor,
                                  onTap: () {
                                    CustomNavigator.instance.pop();
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TextFieldSectionBottomSheet extends StatelessWidget {
  const _TextFieldSectionBottomSheet(
      {required this.amountController,
      required this.availableBalance,
      required this.cubit});

  final TextEditingController? amountController;
  final double availableBalance;
  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AutoSizeText(
          tr('enter_amount'),
          style: TextStyle(color: AppColors.textColor3),
        ),
        SizedBox(
          width: context.width * 0.52,
          child: AmountTextField(
            key: amountSavingTextFieldKey,
            controller: amountController,
            onChanged: (String? value) {
              cubit.emitState();
            },
            suffixIcon: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                tr('sar'),
                style: currencyFieldStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: context.width * 0.037),
              ),
            ),
          ),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        AutoSizeText(
          '${availableBalance.toStringAsFixed(2)}${tr('sar')}',
          style: TextStyle(
              color: AppColors.greenColor,
              fontSize: context.width * 0.05,
              fontWeight: FontWeight.bold),
        ),
        AutoSizeText(
          tr('available_balance'),
          maxLines: 1,
          style: TextStyle(color: AppColors.bottomSheetIconColor),
        ),
      ],
    );
  }
}

class _AddRoleSectionBottomSheet extends StatelessWidget {
  const _AddRoleSectionBottomSheet({
    required this.fromController,
    required this.toController,
    required this.saveController,
    required this.cubit,
  });

  final TextEditingController fromController;
  final TextEditingController toController;
  final TextEditingController saveController;
  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    tr('from'),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  SizedBox(
                    width: context.width * 0.4,
                    child: SavingRoleTextField(
                      controller: fromController,
                      focusNode: cubit.fromFocusNode,
                      onChanged: (String? value) {
                        cubit.emitState();
                      },
                      key: fromSavingKey,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(tr('to')),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  SizedBox(
                      width: context.width * 0.4,
                      child: SavingRoleTextField(
                        controller: toController,
                        focusNode: cubit.toFocusNode,
                        key: toSavingKey,
                        onChanged: (String? value) {
                          cubit.emitState();
                        },
                      ))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(tr('save_role')),
            SizedBox(
              height: context.height * 0.01,
            ),
            SizedBox(
                width: context.width,
                child: SavingRoleTextField(
                  controller: saveController,
                  focusNode: cubit.saveFocusNode,
                  key: saveSavingKey,
                  onChanged: (String? value) {
                    cubit.emitState();
                  },
                ))
          ],
        ),
      ],
    );
  }
}
