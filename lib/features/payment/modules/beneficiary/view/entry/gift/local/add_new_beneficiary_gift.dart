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
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/view/page/send_gift_request.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/first_name_and_last_name_text_fields.dart';

class AddNewBeneficiaryGift extends StatefulWidget {
  final Beneficiary? beneficiary;

  const AddNewBeneficiaryGift({super.key, this.beneficiary});

  @override
  State<AddNewBeneficiaryGift> createState() => _AddNewBeneficiaryGiftState();
}

class _AddNewBeneficiaryGiftState extends State<AddNewBeneficiaryGift> {
  GlobalKey<FormState> beneficiaryValidationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiftCubit>.value(
      value: sl<GiftCubit>(),
      child: BlocBuilder<GiftCubit, GiftState>(
        builder: (BuildContext context, GiftState state) {
          return MainScaffold(
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(15.0),
              child: LoadingButton(
                key: addGiftBeneficiaryContinueButtonKey,
                isLoading: state is GiftLoadingState,
                topPadding: 0,
                onTap: () async {
                  if (beneficiaryValidationFormKey.currentState!.validate()) {
                    final Beneficiary? beneficiary =
                        await sl<GiftCubit>().addNewGiftBeneficiary();
                    if (beneficiary != null) {
                      CustomNavigator.instance.push(
                        routeWidget: SendGiftRequest(
                          beneficiary: beneficiary,
                          dialogTitle: "Gift Send",
                          dialogSubTitle: "Your gift request has been sent",
                        ),
                      );
                      sl<BeneficiaryCubit>()
                          .getBeneficiary(serviceType: ServiceType.gift);
                    }
                  }
                },
                title: tr("continue"),
              ),
            ),
            appBarWidget: MainAppBar(
                backgroundColor: AppColors.lightWhite,
                title: "Add New Beneficiary"),
            scaffold: Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.lightWhite,
              child: Form(
                key: beneficiaryValidationFormKey,
                child: KeyboardActionsWidget(
                  focusNodeModels: <FocusNodeModel>[
                    FocusNodeModel(focusNode: sl<GiftCubit>().giftTitleFocus),
                    FocusNodeModel(
                        focusNode: sl<GiftCubit>().recipientNameFocus),
                    FocusNodeModel(focusNode: sl<GiftCubit>().firstNameFocus),
                    FocusNodeModel(focusNode: sl<GiftCubit>().lastNameFocus),
                    FocusNodeModel(
                        focusNode: sl<GiftCubit>().phoneNumberFocus,
                        onTap: () async {
                          if (beneficiaryValidationFormKey.currentState!
                              .validate()) {
                            final Beneficiary? beneficiary =
                                await sl<GiftCubit>().addNewGiftBeneficiary();
                            if (beneficiary != null) {
                              CustomNavigator.instance.push(
                                routeWidget: SendGiftRequest(
                                  beneficiary: beneficiary,
                                  dialogTitle: "Gift Send",
                                  dialogSubTitle:
                                      "Your gift request has been sent",
                                ),
                              );
                              sl<BeneficiaryCubit>().getBeneficiary(
                                  serviceType: ServiceType.gift);
                            }
                          }
                        }),
                  ],
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        NameTextField(
                          key: giftTitleTextFieldKey,
                          onChanged: (_) {
                            sl<GiftCubit>().updateState();
                          },
                          errorMessage: "required",
                          nameController: sl<GiftCubit>().giftTitleController,
                          focusNode: sl<GiftCubit>().giftTitleFocus,
                          title: "Gift Title",
                          hint: "Gift Title",
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        NameTextField(
                          key: recipientNameTextFieldKey,
                          onChanged: (_) {
                            sl<GiftCubit>().updateState();
                          },
                          errorMessage: "required",
                          nameController:
                              sl<GiftCubit>().recipientNameController,
                          focusNode: sl<GiftCubit>().recipientNameFocus,
                          title: "Recipient's Name",
                          hint: "Recipient's Name",
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        RowOfTwoTextFields(
                          onChanged: () {
                            sl<GiftCubit>().updateState();
                          },
                          firstTextFieldHint: "FName",
                          secondTextFieldHint: "FmName",
                          firstTextFieldController:
                              sl<GiftCubit>().firstNameController,
                          secondTextFieldController:
                              sl<GiftCubit>().lastNameController,
                          secondTextFieldFocusNode:
                              sl<GiftCubit>().lastNameFocus,
                          firstTextFieldFocusNode:
                              sl<GiftCubit>().firstNameFocus,
                        ),
                        PhoneNumberTextField(
                          key: phoneNumberTextFieldKey,
                          onChanged: (String value) {
                            sl<GiftCubit>().updateState();
                          },
                          phoneTitle: "Phone Number",
                          phoneHint: "Phone Number",
                          error: sl<GiftCubit>().phoneNumberError,
                          titleFontSize: 12,
                          phoneNumberController:
                              sl<GiftCubit>().phoneNumberController,
                          phoneNumberFocusNode:
                              sl<GiftCubit>().phoneNumberFocus,
                          hasSuffix: true,
                          suffixWidget: InkWell(
                            onTap: () async {
                              String phone =
                                  (await contactsList(context: context) ?? '')
                                      .replaceAll(numberRegExp, "");
                              if (phone.length > 10) {
                                phone = phone.substring(phone.length - 10);
                              }
                              sl<GiftCubit>().phoneNumberController.text =
                                  phone;
                            },
                            child: Icon(
                              Icons.contacts_outlined,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
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
