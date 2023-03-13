import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/continue_with_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/login_and_language_row_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/res_login_dialog.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/slider_switcher_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/view/component/switcher_content_widget.dart';
import 'package:res_pay_merchant/features/authentication/view/component/auth_common_title.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => LoginCubit(LoginRepository.instance),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (BuildContext context, LoginState state) {
          final LoginCubit cubit = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: MainScaffold(
              scaffold: KeyboardActionsWidget(
                focusNodeModels: <FocusNodeModel>[
                  if (cubit.tabIndex == 0)
                    FocusNodeModel(
                      focusNode: cubit.phoneNumberFocusNode,
                    ),
                  if (cubit.tabIndex == 1)
                    FocusNodeModel(
                      focusNode: cubit.idFocusNode,
                    ),
                  FocusNodeModel(
                      focusNode: cubit.passwordFocusNode,
                      onTap: () async {
                        await _login(cubit);
                      }),
                ],
                child: Center(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: context.width,
                        height: context.height,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: context.width * 0.05,
                            left: context.width * 0.05,
                            top: context.height * 0.075,
                          ),
                          child: SingleChildScrollView(
                            key: loginListKey,
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ///---------------------- Login and language row ----------------------///
                                      LoginAndLanguageRowWidget(
                                        fullHeight: context.height,
                                        fullWidth: context.width,
                                        languageDropDownValue:
                                            cubit.languageDropDownValue,
                                        onChangeLanguageIndex:
                                            (String value) async {
                                          await cubit.changeLanguage(value);
                                        },
                                      ),
                                      SizedBox(
                                        height: context.height * 0.022,
                                      ),

                                      ///---------------------- Welcome Texts ----------------------///
                                      StartupTexts(
                                          title: tr('hi_welcome'),
                                          subTitle: tr('enter_your_account')),

                                      ///---------------------- Slider Widget ----------------------///
                                      SliderSwitcherWidget(
                                        fontSize: context.width * 0.037,
                                        sliderHeight: 50,
                                        sliderWidth: context.width * 0.83,
                                        selectedIndex: cubit.tabIndex,
                                        onChangeIndex: cubit.onChangeTabIndex,
                                        items: <String>[
                                          tr('phone_number'),
                                          tr('id_number'),
                                          // tr('email'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: context.height * 0.02,
                                      ),

                                      ///---------------------- Content of the slider ----------------------///

                                      /// TODO: Refactor
                                      SwitcherContentWidget(
                                        tabIndex: cubit.tabIndex,
                                        passwordPhoneNumberFocusNode:
                                            cubit.passwordFocusNode,
                                        cubit: cubit,
                                        onChanged: () {
                                          cubit.emitStateToUpdateTextFields();
                                        },
                                        idFocusNode: cubit.idFocusNode,
                                        passwordController:
                                            cubit.passwordController,
                                        idController: cubit.idController,
                                        securePasswordPhoneNumberText:
                                            cubit.securePassword,
                                        phoneNumberController:
                                            cubit.phoneNumberController,
                                        phoneNumberFocusNode:
                                            cubit.phoneNumberFocusNode,
                                        changePasswordSecureText:
                                            cubit.changeSecurePassword,
                                        emailController: cubit.emailController,
                                        emailFocusNode: cubit.emailFocusNode,
                                        formKey: cubit.formKey,
                                      ),
                                      SizedBox(
                                        height: context.height * 0.01,
                                      ),

                                      ///---------------------- Forgot Password ----------------------///
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          key: forgetPasswordKey,
                                          onTap: () {
                                            CustomNavigator.instance.pushNamed(
                                                RoutesName.forgetPassword);
                                          },
                                          child: Text(
                                            tr('forgot_password'),
                                            style: TextStyle(
                                                color: AppColors.blueTextColor),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.height * 0.03,
                                      ),

                                      ///---------------------- Login Button ----------------------///

                                      Center(
                                        child: LoadingButton(
                                          key: loginButtonKey,
                                          isLoading: state
                                              is LoginControllerIsLoginLoading,
                                          topPadding: 0,
                                          onTap: () async {
                                            await _login(cubit);
                                          },
                                          title: tr('login'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.height * 0.03,
                                      ),

                                      ///---------------------- or continue with  ----------------------///

                                      const ContinueWithWidget(),

                                      ///---------------------- RES Login Button ----------------------///
                                      LoadingButton(
                                        onTap: () {
                                          ResLogin().dialog(
                                            context: context,
                                          );
                                        },
                                        topPadding: 0,
                                        title: tr('res_login'),
                                        backgroundColor: Colors.white,
                                        fontColor: AppColors.blackColor,
                                        isLoading: false,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: context.height * 0.03,
                                  ),

                                  ///---------------------- Don't have account? ----------------------///
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "${tr("don't_have_account")}  ",
                                            style: TextStyle(
                                                color: AppColors.textColor3,
                                                fontSize:
                                                    context.width * 0.029)),
                                        TextSpan(
                                            text: tr("sign_up"),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                CustomNavigator.instance
                                                    .pushNamed(
                                                        RoutesName.register);
                                              },
                                            style: TextStyle(
                                                color: AppColors.blueTextColor,
                                                fontSize:
                                                    context.width * 0.025)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // ),
    );
  }

  Future<void> _login(LoginCubit cubit) async {
    if (cubit.formKey.currentState!.validate()) {
      final String message = await cubit.onTapButton(onSuccess: () {
        CustomNavigator.instance.pushNamedAndRemoveUntil(
            RoutesName.authDashboard, (Route<dynamic> route) => false);
      });
      if (message.isNotEmpty) {
        MyToast(message);
      }
    }
  }
}
