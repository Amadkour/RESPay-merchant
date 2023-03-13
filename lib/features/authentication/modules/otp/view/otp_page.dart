import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/controller/otp_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/view/component/pin_code_textfield.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({
    super.key,
    this.onSuccess,
    this.isFromAuth = true,
  });

  final Future<void> Function(String? value)? onSuccess;
  final bool isFromAuth;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpCubit>(
        create: (BuildContext context) => OtpCubit(
              onSuccess!,
              isFromAuth,
            ),
        child: BlocConsumer<OtpCubit, OtpState>(
            listener: (BuildContext context, OtpState state) {
          if (state is OtpError) {
            MyToast(state.failure.message);
          }
        }, builder: (BuildContext context, OtpState state) {
          final OtpCubit controller = context.read<OtpCubit>();
          return WillPopScope(
            onWillPop: () async => false,
            child: MainScaffold(
              scaffold: Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  appBar: MainAppBar(
                    title: 'OTP',
                    showBackButton: !isFromAuth,
                    backgroundColor: Colors.white,
                  ),
                  body: <Type>[OtpLoaded, OtpLoading]
                          .contains(state.runtimeType)
                      ? SizedBox(
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blackColor,
                            ),
                          ),
                        )

                      ///normal flow
                      : InkWell(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ///Logo
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24, right: 20, left: 20),
                                  child: AutoSizeText(
                                    tr('Enter OTP Code'),
                                    maxFontSize: 20,
                                    minFontSize: 10,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SemiBold',
                                      height: 2.5,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 60),
                                    child: Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                          tr('We have sent OTP Code to'),
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor3,
                                            fontFamily: 'SemiBold',
                                            height: 2.5,
                                          ),
                                        ),
                                        AutoSizeText(
                                          loggedInUser.phone ?? "",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor3,
                                            fontFamily: 'SemiBold',
                                            height: 2.5,
                                          ),
                                        ),
                                      ],
                                    )),

                                ///-------------------------( pin code text field )----------------///
                                MyPinCode(text: controller.otpController.text),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  //
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      tr('resendpass2'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 14,
                                              color: AppColors.blueTextColor),
                                    ),
                                    Text(
                                      "00:${controller.start}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontSize: 14,
                                            color: AppColors.blueTextColor,
                                          ),
                                    )
                                  ],
                                ),
                                const Spacer(),

                                SafeArea(
                                  child: AnimatedContainer(
                                    padding: const EdgeInsets.only(
                                        top: 30,
                                        right: 40,
                                        left: 40,
                                        bottom: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        topRight: Radius.circular(32),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    child: GridView(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 4 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        ...List<Widget>.generate(
                                          controller.numberList.length,
                                          (int index) => InkWell(
                                            key: Key(
                                                "pin_code_${controller.numberList[index]}"),
                                            onTap: () {
                                              if (controller.otpController.text
                                                      .length <
                                                  4) {
                                                controller.otpController.text +=
                                                    controller
                                                        .numberList[index];
                                                controller.onChangeOtp();
                                              }
                                            },
                                            child: Text(
                                              tr(controller.numberList[index]),
                                              style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 32,
                                                  fontFamily: 'Plain',
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: InkWell(
                                            onTap: () {
                                              if (controller.otpController.text
                                                  .isNotEmpty) {
                                                controller.otpController.text =
                                                    controller
                                                        .otpController.text
                                                        .substring(
                                                            0,
                                                            controller
                                                                    .otpController
                                                                    .text
                                                                    .length -
                                                                1);
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 7),
                                              child: Icon(
                                                CupertinoIcons.delete_left_fill,
                                                color: Color(0xff8B969A),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        )),
            ),
          );
        }));
  }
}
