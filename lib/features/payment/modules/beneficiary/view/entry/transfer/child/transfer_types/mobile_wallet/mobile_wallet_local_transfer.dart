import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/drop_down_lists/drop_down_list_of_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/text_field_label.dart';

class MobileWalletLocalTransfer extends StatefulWidget {
  const MobileWalletLocalTransfer({super.key});

  @override
  State<MobileWalletLocalTransfer> createState() =>
      _MobileWalletLocalTransferState();
}

class _MobileWalletLocalTransferState extends State<MobileWalletLocalTransfer> {
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
    return Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.lightWhite,
        child: KeyboardActionsWidget(
          focusNodeModels: <FocusNodeModel>[
            FocusNodeModel(focusNode: benificiaryController.firstNameFocusNode),
            FocusNodeModel(focusNode: benificiaryController.lastNameFocusNode),
            FocusNodeModel(
                focusNode: benificiaryController.phoneNumberFocusNode),
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
                        benificiaryController.updateState();
                      },
                      firstTextFieldHint: "FName",
                      secondTextFieldHint: "FmName",
                      firstTextFieldFocusNode:
                          benificiaryController.firstNameFocusNode,
                      secondTextFieldFocusNode:
                          benificiaryController.lastNameFocusNode,
                      onFirstFieldChanged: (String? value) =>
                          benificiaryController.firstName = value,
                      onSecondFieldChanged: (String? value) =>
                          benificiaryController.lastName = value,
                    ),
                    PhoneNumberTextField(
                      hasSuffix: true,
                      phoneNumberFocusNode:
                          benificiaryController.phoneNumberFocusNode,
                      key: phoneNumberTextFieldKey,
                      titleFontSize: 12,
                      onChanged: (String value) {
                        benificiaryController.phoneNumber = value;
                        sl<BeneficiaryCubit>().phoneNumberState();
                      },
                      phoneHint: "Phone Number",
                      hintFontSize: 12,
                      error: context.watch<BeneficiaryCubit>().phoneNumberError,
                      phoneTitle: "Phone Number",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
