import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/res_dialog/res_dialog_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/slider_switcher_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/switcher_content_widget.dart';
/// Bottom sheet make you login with RES credentials
/// Part of [LoginPage]
class ResLogin {
  void dialog({
    required BuildContext context,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey();

    showDialog(
      context: context,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext context, dynamic setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 30),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: Container(
              width: context.width,
              height: context.height * 0.8,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: BlocProvider<ResDialogCubit>(
                    create: (BuildContext context) => ResDialogCubit(),
                    child: BlocBuilder<ResDialogCubit, ResDialogState>(
                      builder: (BuildContext context, ResDialogState state) {
                        final ResDialogCubit cubit =
                            BlocProvider.of<ResDialogCubit>(context);
                        return Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ///--------------------------- bold close icon ---------------------------///
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    CustomNavigator.instance.pop();
                                  },
                                  child: Text(
                                    String.fromCharCode(Icons.close.codePoint),
                                    style: TextStyle(
                                      inherit: false,
                                      color: AppColors.blackColor,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: Icons.close.fontFamily,
                                      package: Icons.close.fontPackage,
                                    ),
                                  ),
                                ),
                              ),

                              ///--------------------------- Startup Image ---------------------------///
                              SizedBox(
                                height: context.height * 0.126,
                                width: context.height * 0.126,
                                child: MyImage.assets(
                                    url:
                                        'assets/images/login/res_login_start_dialog.png'),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              ///--------------------------- Welcome Texts ---------------------------///
                              Text(
                                tr('login_with_res_app'),
                                style: TextStyle(
                                    fontSize: context.width * 0.047,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                tr('enter_res_account'),
                                style: TextStyle(
                                    fontSize: context.width * 0.035,
                                    color: AppColors.textColor3),
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              ///--------------------------- Slider ---------------------------///

                              SliderSwitcherWidget(
                                fontSize: context.width * 0.027,
                                sliderHeight: 50,
                                sliderWidth: context.width * 0.7,
                                selectedIndex: cubit.tabIndex,
                                onChangeIndex: cubit.changeTabIndex,
                                items: <String>[
                                  tr('phone_number'),
                                  tr('id_number'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///--------------------------- Switcher Contents ---------------------------///
                              SwitcherContentWidget(
                                tabIndex: cubit.tabIndex,
                                passwordPhoneNumberFocusNode:
                                    cubit.dialogPasswordPhoneNumberFocusNode,
                                idFocusNode: cubit.dialogIdFocusNode,
                                phoneNumberFocusNode:
                                    cubit.dialogPhoneNumberFocusNode,
                                passwordController:
                                    cubit.dialogPasswordPhoneNumberController,
                                idController: cubit.dialogIDController,
                                phoneNumberController:
                                    cubit.dialogPhoneNumberController,
                                securePasswordPhoneNumberText:
                                    cubit.dialogSecurePasswordPhoneNumberText,
                                changePasswordSecureText:
                                    cubit.changeSecurePassword,
                                formKey: cubit.formKey,
                                onChanged: () {},
                              ),

                              ///---------------------- Forgot Password ----------------------///
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  tr('forgot_password'),
                                  style: TextStyle(
                                      color: AppColors.blueTextColor,
                                      fontSize: context.width * 0.025),
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.03,
                              ),

                              ///---------------------- Login Button ----------------------///
                              Center(
                                child: LoadingButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (cubit.tabIndex == 0) {
                                        await cubit.resLoginWithPhoneNumber();
                                      } else {
                                        await cubit.resLoginWithIDNumber();
                                      }
                                    }
                                  },
                                  isLoading: false,
                                  enable: false,
                                  title: tr('login'),
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.05,
                              ),
                            ],
                          ),
                        );
                      },
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
