import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/iban_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/view/component/bank_name_drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_down_list_of_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class BankAccountLocalTransfer extends StatefulWidget {
  const BankAccountLocalTransfer({super.key});

  @override
  State<BankAccountLocalTransfer> createState() =>
      _BankAccountLocalTransferState();
}

class _BankAccountLocalTransferState extends State<BankAccountLocalTransfer> {
  final GlobalKey<FormState> international = GlobalKey<FormState>();
  final BeneficiaryCubit beneficiaryController = sl<BeneficiaryCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    beneficiaryController.setCurrentFormKey(international);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.lightWhite,
        child: KeyboardActionsWidget(
          focusNodeModels: <FocusNodeModel>[
            FocusNodeModel(focusNode: beneficiaryController.firstNameFocusNode),
            FocusNodeModel(focusNode: beneficiaryController.lastNameFocusNode),
            FocusNodeModel(
                focusNode: beneficiaryController.accountNumberFocusNode),
            FocusNodeModel(
                focusNode: beneficiaryController.ibanNumberFocusNode),
          ],
          child: ListView(
            children: <Widget>[
              Form(
                  key: international,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildLabel(label: "Method Type"),
                      const SizedBox(
                        height: 5,
                      ),
                      const DropDownListOfMethodTypes(),
                      const SizedBox(
                        height: 18,
                      ),
                      RowOfTwoTextFields(
                        onChanged: () {
                          beneficiaryController.updateState();
                        },
                        firstTextFieldFocusNode:
                            beneficiaryController.firstNameFocusNode,
                        secondTextFieldFocusNode:
                            beneficiaryController.lastNameFocusNode,
                        firstTextFieldHint: "FName",
                        secondTextFieldHint: "FmName",
                        onFirstFieldChanged: (String? value) =>
                            beneficiaryController.firstName = value,
                        onSecondFieldChanged: (String? value) =>
                            beneficiaryController.lastName = value,
                      ),
                      buildLabel(label: "Bank Name"),
                      const SizedBox(
                        height: 5,
                      ),
                      const DropDownListOfBankNames(),
                      const SizedBox(
                        height: 18,
                      ),
                      AccountNumText(
                        titleFontSize: 12,
                        focusNode: beneficiaryController.accountNumberFocusNode,
                        key: accountNumberTextFieldKey,
                        onChanged: (String value) {
                          beneficiaryController.accountNumber = value;
                          beneficiaryController.accountNumberState();
                        },
                        accountNumberError: context
                            .watch<BeneficiaryCubit>()
                            .accountNumberError,
                        title: "Account Number/Address",
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      IbanText(
                        titleFontSize: 12,
                        key: iBANTextFieldKey,
                        focusNode: beneficiaryController.ibanNumberFocusNode,
                        iBANError: context.watch<BeneficiaryCubit>().ibanError,
                        onChanged: (String value) {
                          beneficiaryController.iban = value;
                          beneficiaryController.ibanNumberState();
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
