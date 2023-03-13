import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/iban_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/view/component/bank_name_drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/add_bank_account_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

class AddBankAccount extends StatelessWidget {
  const AddBankAccount({super.key, required this.withdrawCubit});
  final WithdrawCubit withdrawCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddBankAccountCubit>(
      create: (BuildContext context) => AddBankAccountCubit(),
      child: BlocBuilder<AddBankAccountCubit, AddBankAccountState>(
        builder: (BuildContext context, AddBankAccountState state) {
          final AddBankAccountCubit controller =
              context.read<AddBankAccountCubit>();
          return MainScaffold(
            appBarWidget: MainAppBar(
              title: tr('Add_bank'),
            ),
            scaffold: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      NameTextField(
                        key: recipientNameTextKey,
                        nameControllerError: controller.fullNameError,
                        hint: 'type_your_name',
                        title: "recipient_name",
                        onChanged: (String v) {
                          controller.onNameChanged(v);
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        tr('bank_name'),
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const DropDownListOfBankNames(),
                      const SizedBox(
                        height: 18,
                      ),
                      AccountNumText(
                        onChanged: (String v) {
                          controller.onAccountNumberChanged(v);
                        },
                        key: accountNumberTextKey,
                        accountNumberError: controller.accountNumberError,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      IbanText(
                        onChanged: (String v) {
                          controller.onIBanChanged(v);
                        },
                        key: ibanTextFieldKeyTextKey,
                        iBANError: controller.ibanError,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: LoadingButton(
                key: withdrawAddAccountKey,
                title: tr('save_account'),
                onTap: () async {
                  if (controller.enableButton) {
                    final bool result = await controller.createAccount();
                    if (result) {
                      withdrawCubit.getBankAccounts(forceLoad: true);
                      CustomNavigator.instance.pop();
                    }
                  }
                },
                isLoading: state is CreateAccountLoading,
              ),
            ),
          );
        },
      ),
    );
  }
}
