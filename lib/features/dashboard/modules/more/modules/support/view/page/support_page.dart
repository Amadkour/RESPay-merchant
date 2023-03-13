import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/email_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key, required this.supportValidationFormKey});

  final GlobalKey<FormState> supportValidationFormKey;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBarWidget: const MainAppBar(
          title: "Support",
        ),
        scaffold: Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.backgroundColor,
          child: BlocProvider<SupportCubit>.value(
            value: sl<SupportCubit>(),
            child: BlocBuilder<SupportCubit, SupportState>(
              builder: (BuildContext context, SupportState state) {
                final SupportCubit supportCubit = sl<SupportCubit>();
                if (state is SupportErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    MyToast(supportCubit.errorMessage!, fontColor: Colors.red);
                  });
                }
                if (state is SupportSentIssueDone) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await CustomSuccessDialog.instance.show(
                      onPressedFirstButton: () {},
                      haveSecondButton: false,
                      title: "Your issue has been sent",
                      subTitle: "We received your message, thank you!",
                      context: context,
                    );
                    supportCubit.resetSupportState();
                  });
                }

                return SupportFormBody(
                  supportValidationFormKey: supportValidationFormKey,
                  supportCubit: supportCubit,
                  state: state,
                );
              },
            ),
          ),
        ));
  }
}

class SupportFormBody extends StatelessWidget {
  const SupportFormBody({
    super.key,
    required this.state,
    required this.supportValidationFormKey,
    required this.supportCubit,
  });

  final GlobalKey<FormState> supportValidationFormKey;
  final SupportCubit supportCubit;
  final SupportState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: supportValidationFormKey,
      child: KeyboardActionsWidget(
        focusNodeModels: <FocusNodeModel>[
          FocusNodeModel(focusNode: supportCubit.firstNameFocus),
          FocusNodeModel(focusNode: supportCubit.emailFocus),
          FocusNodeModel(
              focusNode: supportCubit.supportNameFocus,
              onTap: () {
                if (supportValidationFormKey.currentState!.validate()) {
                  supportCubit.sendIssue();
                }
              }),
        ],
        child: SingleChildScrollView(
          key: sendIssueScrollList,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NameTextField(
                minLength: 4,
                key: firstNameTextFieldKey,
                hint: 'Input',
                nameController: supportCubit.firstNameController,
                focusNode: supportCubit.firstNameFocus,
                title: 'First Name',
              ),
              const SizedBox(
                height: 15,
              ),
              EmailTextField(
                key: emailTextFieldKey,
                emailTitle: "email",
                emailHint: "Input",
                emailController: supportCubit.emailController,
                focusNode: supportCubit.emailFocus,
                onChanged: (String value) {
                  //sl<SupportCubit>().updateState();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              NameTextField(
                multiLine: 5,
                minLength: 10,
                key: supportMessageTextFieldKey,
                hint: 'Input',
                nameController: supportCubit.supportController,
                focusNode: supportCubit.supportNameFocus,
                title: 'Support',
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: LoadingButton(
                      key: sendButtonKey,
                      title: "send",
                      isLoading: state is SupportLoadingState,
                      onTap: () {
                        if (supportValidationFormKey.currentState!.validate()) {
                          supportCubit.sendIssue();
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
