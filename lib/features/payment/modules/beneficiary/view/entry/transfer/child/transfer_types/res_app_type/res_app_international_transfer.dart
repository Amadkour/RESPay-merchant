import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/contacts/view/page/contact_list_page.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/country_and_currency_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_down_list_of_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_list_of_relation_ships.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class ResAppInternationalTransfer extends StatefulWidget {
  const ResAppInternationalTransfer({super.key});

  @override
  State<ResAppInternationalTransfer> createState() =>
      _ResAppInternationalTransferState();
}

class _ResAppInternationalTransferState
    extends State<ResAppInternationalTransfer> {
  final BeneficiaryCubit beneficiaryController = sl<BeneficiaryCubit>();
  final GlobalKey<FormState> international = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    beneficiaryController.setCurrentFormKey(international);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionsWidget(
      focusNodeModels: <FocusNodeModel>[
        FocusNodeModel(focusNode: beneficiaryController.firstNameFocusNode),
        FocusNodeModel(focusNode: beneficiaryController.lastNameFocusNode),
        FocusNodeModel(focusNode: beneficiaryController.phoneNumberFocusNode),
      ],
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.lightWhite,
            child: Form(
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
                  buildLabel(label: "Relationship with the beneficiary"),
                  const SizedBox(
                    height: 5,
                  ),
                  const DropListOfRelationShips(),
                  const SizedBox(
                    height: 18,
                  ),
                  PhoneNumberTextField(
                    key: phoneNumberTextFieldKey,
                    onChanged: (String value) {
                      beneficiaryController.phoneNumber = value;
                      beneficiaryController.phoneNumberState();
                    },
                    phoneNumberFocusNode:
                        beneficiaryController.phoneNumberFocusNode,
                    titleFontSize: 12,
                    hintFontSize: 12,
                    phoneTitle: "Phone Number",
                    phoneHint: "Phone Number",
                    error: context.watch<BeneficiaryCubit>().phoneNumberError,
                    hasSuffix: true,
                    suffixWidget: InkWell(
                      onTap: () async {
                        String phone =
                            (await contactsList(context: context) ?? '')
                                .replaceAll(numberRegExp, "");
                        if (phone.length > 10) {
                          phone = phone.substring(phone.length - 10);
                        }
                        beneficiaryController.phoneNumber = phone;
                      },
                      child: Icon(
                        Icons.contacts_outlined,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
