import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/account_num_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/country_and_currency_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_down_list_of_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_list_of_relation_ships.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/swift_code_and_nationality_drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/wallet_name_drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class MobileWalletInternationalTransfer extends StatefulWidget {
  const MobileWalletInternationalTransfer({super.key});

  @override
  State<MobileWalletInternationalTransfer> createState() =>
      _MobileWalletInternationalTransferState();
}

class _MobileWalletInternationalTransferState
    extends State<MobileWalletInternationalTransfer> {
  final GlobalKey<FormState> international = GlobalKey<FormState>();
  final BeneficiaryCubit benificiaryController = sl<BeneficiaryCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    benificiaryController.setCurrentFormKey(international);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionsWidget(
      focusNodeModels: <FocusNodeModel>[
        FocusNodeModel(focusNode: benificiaryController.swiftCodeFocusNode),
        FocusNodeModel(focusNode: benificiaryController.firstNameFocusNode),
        FocusNodeModel(focusNode: benificiaryController.lastNameFocusNode),
        FocusNodeModel(focusNode: benificiaryController.accountNumberFocusNode),
      ],
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.lightWhite,
            child: Form(
              key: international,
              onChanged: () {},
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
                  Row(
                    children: <Widget>[
                      Expanded(child: buildLabel(label: "Country")),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: buildLabel(label: "Beneficiary Currency")),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CountryAndCurrencyList(),
                  const SizedBox(
                    height: 18,
                  ),
                  buildLabel(label: "Wallet Name"),
                  const SizedBox(
                    height: 5,
                  ),
                  const DropDownListOfWalletNames(),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: buildLabel(label: "Swift Code")),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(child: buildLabel(label: "Nationality")),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SwiftCodeWithNationalityRow(),
                  const SizedBox(
                    height: 18,
                  ),
                  RowOfTwoTextFields(
                    onChanged: () {
                      benificiaryController.updateState();
                    },
                    firstTextFieldFocusNode:
                        benificiaryController.firstNameFocusNode,
                    secondTextFieldFocusNode:
                        benificiaryController.lastNameFocusNode,
                    firstTextFieldHint: "FName",
                    secondTextFieldHint: "FmName",
                    onFirstFieldChanged: (String? value) =>
                        benificiaryController.firstName = value,
                    onSecondFieldChanged: (String? value) =>
                        benificiaryController.lastName = value,
                  ),
                  buildLabel(label: "Relationship with the beneficiary"),
                  const SizedBox(
                    height: 5,
                  ),
                  const DropListOfRelationShips(),
                  const SizedBox(
                    height: 18,
                  ),
                  AccountNumText(
                    titleFontSize: 12,
                    focusNode: benificiaryController.accountNumberFocusNode,
                    key: accountNumberTextFieldKey,
                    onChanged: (String value) {
                      benificiaryController.accountNumber = value;
                      benificiaryController.accountNumberState();
                    },
                    accountNumberError:
                        context.watch<BeneficiaryCubit>().accountNumberError,
                    title: "Account Number/Address",
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
