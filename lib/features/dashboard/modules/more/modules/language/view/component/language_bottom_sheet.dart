import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/controller/language_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/view/component/language_row_widget.dart';

void showLanguageBottomSheet(BuildContext context) {
  showCustomBottomSheet(
      context: context,
      isTwoButtons: false,
      body: BlocProvider<LanguageCubit>(
        create: (BuildContext context) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (BuildContext context, LanguageState state) {
            final LanguageCubit cubit = BlocProvider.of(context);

            if (state is LanguageLoading) {
              return const Center(child: NativeLoading());
            } else {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  LanguageRowWidget(
                      radioKey: englishRadioButtonKey,
                      imageUrl: 'assets/icons/login/english.png',
                      title: tr(cubit.languageModels[1].name!.toLowerCase()),
                      value: 'en',
                      groupValue: cubit.radioGroupValue,
                      toggleLanguage: cubit.toggleLanguage),
                  const SizedBox(
                    height: 10,
                  ),
                  LanguageRowWidget(
                    radioKey: arabicRadioButtonKey,
                    imageUrl: 'assets/images/flags/Saudi-Arabia-Flag-icon.png',
                    title: tr(cubit.languageModels[0].name!.toLowerCase()),
                    value: 'ar',
                    groupValue: cubit.radioGroupValue,
                    toggleLanguage: cubit.toggleLanguage,
                  ),
                  LoadingButton(
                    key: changeLanguageConfirmButtonKey,
                    isLoading: state is LanguageChangeLanguageLoading,
                    title: tr('change_now'),
                    onTap: () async {
                      final String message = await cubit.onTapButton();
                      if (message.isNotEmpty) {
                        sl<MoreCubit>().rebuildScreenToUpdateLanguage();
                        CustomNavigator.instance.pop();
                        MyToast(
                          message,
                        );
                      }
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
      blackButtonTitle: tr('change_now'),
      hasButtons: false,
      title: tr('select_language'));
}
