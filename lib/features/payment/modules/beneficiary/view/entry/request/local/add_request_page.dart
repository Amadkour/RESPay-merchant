import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/contacts/view/page/contact_list_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/view/page/request_amount_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';

class AddRequestPage extends StatefulWidget {
  final String? phoneNumber;
  final Beneficiary? beneficiary;

  const AddRequestPage({super.key, this.beneficiary, this.phoneNumber});

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  final GlobalKey<FormState> requestBeneficiaryValidationFormKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    sl<RequestCubit>().reset(phoneNumber: widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCubit>.value(
      value: sl<RequestCubit>(),
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (BuildContext context, RequestState state) {
          final RequestCubit requestCubit = sl<RequestCubit>();
          return MainScaffold(
            appBarWidget: MainAppBar(
                backgroundColor: AppColors.lightWhite, title: "Add Request"),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(12.0),
              child: LoadingButton(
                key: addRequestBeneficiaryContinueButtonKey,
                title: tr("continue"),
                topPadding: 0,
                isLoading: state is RequestLoadingState,
                onTap: () async {
                  if (requestBeneficiaryValidationFormKey.currentState!
                      .validate()) {
                    final Beneficiary? beneficiary =
                        await requestCubit.addNewRequestBeneficiary();
                    if (beneficiary != null) {
                      CustomNavigator.instance.push(
                          routeWidget: RequestAmountPage(
                        beneficiary: beneficiary,
                        dialogSubTitle: "Your payment request has been sent",
                        dialogTitle: "Request Send",
                      ));
                      sl<BeneficiaryCubit>().getBeneficiary(
                          serviceType: ServiceType.request_money);
                    }
                  }
                },
              ),
            ),
            scaffold: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppColors.lightWhite,
              child: Form(
                key: requestBeneficiaryValidationFormKey,
                child: KeyboardActionsWidget(
                  focusNodeModels: <FocusNodeModel>[
                    FocusNodeModel(focusNode: requestCubit.phoneNumberFocus),
                    FocusNodeModel(focusNode: requestCubit.firstNameFocus),
                    FocusNodeModel(focusNode: requestCubit.familyNameFocus),
                  ],
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PhoneNumberTextField(
                          onChanged: (String value) {
                            requestCubit.updateState();
                          },
                          key: phoneNumberTextFieldKey,
                          phoneTitle: "Phone Number",
                          phoneHint: "Phone Number",
                          titleFontSize: 12,
                          error: requestCubit.phoneNumberError,
                          phoneNumberController:
                              requestCubit.phoneNumberController,
                          phoneNumberFocusNode: requestCubit.phoneNumberFocus,
                          hasSuffix: true,
                          suffixWidget: InkWell(
                            onTap: () async {
                              String phone =
                                  (await contactsList(context: context) ?? '')
                                      .replaceAll(numberRegExp, "");
                              if (phone.length > 10) {
                                phone = phone.substring(phone.length - 10);
                              }
                              requestCubit.phoneNumberController.text = phone;
                            },
                            child: Icon(
                              Icons.contacts_outlined,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RowOfTwoTextFields(
                          onChanged: () {
                            requestCubit.updateState();
                          },
                          firstTextFieldHint: "FName",
                          secondTextFieldHint: "FmName",
                          firstTextFieldController:
                              requestCubit.firstNameController,
                          secondTextFieldController:
                              requestCubit.lastNameController,
                          secondTextFieldFocusNode:
                              requestCubit.familyNameFocus,
                          firstTextFieldFocusNode: requestCubit.firstNameFocus,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
