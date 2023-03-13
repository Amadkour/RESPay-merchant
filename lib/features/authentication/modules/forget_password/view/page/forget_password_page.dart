import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/id_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/controller/forget_password/forget_password_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/forget_passwod_repository.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/view/component/expansion_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/view/otp_page.dart';
import 'package:res_pay_merchant/features/authentication/view/component/auth_common_title.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: tr('forgot_password_title'),
        backgroundColor: Colors.white,
      ),
      scaffold: Padding(
        padding: EdgeInsets.only(
            right: context.width * 0.05,
            left: context.width * 0.05,
            top: context.height * 0.055,
            bottom: context.height * 0.05),
        child: BlocProvider<ForgetPasswordCubit>(
          create: (BuildContext context) =>
              ForgetPasswordCubit(ForgetPasswordRepository.instance),
          child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (BuildContext context, ForgetPasswordState state) {
              final ForgetPasswordCubit cubit =
                  BlocProvider.of<ForgetPasswordCubit>(context);
              return SingleChildScrollView(
                key: forgetPasswordListKey,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      StartupTexts(
                        title: tr('forgot_password_title'),
                        subTitle: tr('select_which_contact'),
                      ),

                      /// ------------------------------- Via Message -------------------------------///
                      ExpansionWidget(
                        imageUrl:
                            'assets/icons/forget_password/via-message.svg',
                        changeExpansionState: cubit.changePhoneExpansion,
                        isExpanded: cubit.phoneExpanded,
                        title: tr('via_message'),
                        widget: Form(
                          key: cubit.phoneFormKey,
                          child: PhoneNumberTextField(
                            key: phoneNumberTextFieldKey,
                            phoneNumberController: cubit.phoneController,
                            phoneHint: tr('phone_number'),
                            fillColor: const Color(0xffF9F9F9),
                            fullWidth: context.width,
                            error: cubit.phoneError,
                            phoneTitle: tr('phone_number'),
                            onChanged: (String? value) {},
                            phoneNumberFocusNode: cubit.phoneFocusNode,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.05,
                      ),

                      /// ------------------------------- Via Email -------------------------------///
                      // ExpansionWidget(
                      //   size: size,
                      //   changeExpansionState: cubit.changeEmailExpansion,
                      //   isExpanded: cubit.emailExpanded,
                      //   expansionImage: Stack(
                      //     children: <Widget>[
                      //       CircleAvatar(
                      //         radius: context.width * 0.04,
                      //         backgroundColor: const Color(0xffEDFAF5),
                      //         child: MyImage.svgAssets(
                      //           url:
                      //               'assets/icons/forget_password/via-email.svg',
                      //           width: context.width * 0.04,
                      //           height: context.width * 0.04,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      //   title: tr('via_email'),
                      //   widget: Form(
                      //     key: cubit.emailFormKey,
                      //     child: EmailTextField(
                      //       emailController: cubit.emailController,
                      //       emailControllerError: cubit.emailError,
                      //       emailTitle: tr('email'),
                      //       emailHint: tr('email'),
                      //       // fullWidth: context.width,
                      //       fillColor: const Color(0xffF9F9F9),
                      //       focusNode: cubit.emailFocusNode,
                      //       onTab: () {
                      //         FocusScope.of(context).unfocus();
                      //         cubit.emailFocusNode.requestFocus();
                      //       },
                      //       onChanged: () {},
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: context.height * 0.05,
                      // ),

                      /// ------------------------------- Via ID Number -------------------------------///
                      ExpansionWidget(
                        changeExpansionState: cubit.changeIDNumberExpansion,
                        isExpanded: cubit.idExpanded,
                        expansionImage: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: context.width * 0.04,
                              backgroundColor: const Color(0xffEDFAF5),
                              child: MyImage.svgAssets(
                                url:
                                    'assets/icons/forget_password/via-email.svg',
                                width: context.width * 0.04,
                                height: context.width * 0.04,
                              ),
                            )
                          ],
                        ),
                        title: tr('via_id_number'),
                        widget: Form(
                          key: cubit.idFormKey,
                          child: IDTextField(
                            key: idForgetPasswordTextFieldKey,
                            idController: cubit.idController,
                            error: cubit.idError,
                            idTitle: tr('id_number'),
                            idHint: tr('id_number'),
                            fullWidth: context.width,
                            fillColor: const Color(0xffF9F9F9),
                            idFocusNode: cubit.idFocusNode,
                            onChanged: (String v) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.2,
                      ),

                      /// ------------------------------- Continue Button-------------------------------///
                      LoadingButton(
                        key: confirmButtonForgetPasswordKey,
                        title: tr('continue'),
                        topPadding: 0,
                        isLoading: state is ForgetPasswordLoading,
                        onTap: () async {
                          if (cubit.numberOFTextFieldsHaveText > 1) {
                            MyToast(tr('Please_enter_only_one_method'));
                          } else if (cubit.numberOFTextFieldsHaveText == 0) {
                            MyToast(tr('Please_enter_one_of_these_methods'));
                          } else if (cubit.myFormKey.currentState!.validate()) {
                            final String message = await cubit.onTabButton(
                              onSuccess: (String otp) async {
                                /// Navigate to OTP Page to confirm code and if succeeded go to Create new password Screen
                                CustomNavigator.instance.push(
                                  routeWidget: OTPPage(
                                    onSuccess: (String? value) async {
                                      CustomNavigator.instance.pushNamed(
                                          RoutesName.createNewPassword,
                                          arguments: cubit.continueMap);
                                    },
                                  ),
                                );
                              },
                            );
                            if (message.isNotEmpty) {
                              MyToast(message);
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
