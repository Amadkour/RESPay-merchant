import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/view/component/pin_code_textfield.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class PinCodePage extends StatelessWidget {
  const PinCodePage({
    super.key,
    required this.setup,
    this.onSuccess,
    this.canPop = true,
  });

  final bool setup;
  final Future<String?> Function()? onSuccess;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeCubit>.value(
        value: sl<PinCodeCubit>()
          ..init(
            onSuccess: onSuccess,
            setup: setup,
          ),
        child: BlocConsumer<PinCodeCubit, PinCodeState>(
            listener: (BuildContext context, PinCodeState state) {
          if (state is PinCodeError) {
            MyToast(state.failure.message);
          }
        }, builder: (BuildContext context, PinCodeState state) {
          final PinCodeCubit controller = context.watch<PinCodeCubit>();
          return WillPopScope(
            onWillPop: () async {
              if (canPop) {
                return true;
              } else {
                MyToast("Can't pop from this page");
                return false;
              }
            },
            child: MainScaffold(
              scaffold: Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  appBar: MainAppBar(
                    title: '${setup ? 'CREATE' : ''} PIN',
                    showBackButton: canPop,
                    onBack: () {
                      if (setup) {
                        CustomNavigator.instance.pop(numberOfPop: 2);
                      } else {
                        CustomNavigator.instance.maybePop();
                      }
                    },
                    backgroundColor: Colors.white,
                  ),
                  body: state is PinCodeLoading
                      ? const Center(
                          child: NativeLoading(),
                        )
                      : Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          ///-------------------------( Logo )----------------///
                          Padding(
                            padding: const EdgeInsets.only(top: 24, right: 20, left: 20),
                            child: AutoSizeText(
                              setup ? 'Enter a new pin code' : tr('Enter PIN Code'),
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

                          const Spacer(),

                          ///( pin code text field )----------------///
                          Center(
                            child: MyPinCode(text: controller.pinCode),
                            // PinCodeTextField(
                            //   key: pinCodeTextFieldKey,
                            //   controller: controller.pinController,
                            //   isCupertino: true,
                            //   highlightColor: const Color(0xffFAFAFA),
                            //   highlightPinBoxColor: AppColors.otpBackgroundColor,
                            //   pinBoxRadius: 10,
                            //   defaultBorderColor: AppColors.otpBorderColor,
                            //   hasTextBorderColor: AppColors.otpBorderColor,
                            //   pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: (context.width) * 0.015),
                            //   pinBoxHeight: (context.width) * 0.14,
                            //   pinBoxWidth: (context.width) * 0.14,
                            //   pinBoxColor: AppColors.backgroundColor,
                            //   keyboardType: TextInputType.none,
                            //   pinTextStyle:
                            //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                            //   onDone: (String value) {},
                            // ),
                          ),

                          ///---------------------- Don't have account? ----------------------///
                          if (!canPop) ...<Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "${tr('forget_your_pin')}  ",
                                        style: TextStyle(
                                            color: AppColors.textColor3,
                                            fontSize: context.width * 0.029)),
                                    TextSpan(
                                        text: tr("login"),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            CustomNavigator.instance
                                                .pushReplacementNamed(RoutesName.login);
                                          },
                                        style: TextStyle(
                                            color: AppColors.blueTextColor,
                                            fontSize: context.width * 0.025)),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          ///-------------------------( pin code Resend again text  )----------------///

                          const Spacer(),
                          SafeArea(
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.only(top: 30, right: 40, left: 40, bottom: 10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                              child: GridView(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 4 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ...List<Widget>.generate(
                                    controller.numberList.length,
                                    (int index) {
                                      return InkWell(
                                        key: Key("pin_code_${controller.numberList[index]}"),
                                        onTap: () {
                                          controller.onAddKeyboard(
                                              context, controller.numberList[index]);
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
                                      );
                                    },
                                  ),

                                  setup ||
                                          !((controller.fingerPrintEnabled &&
                                                  controller.hasFingerPrintId) ||
                                              (controller.faceIdEnabled && controller.hasFaceId))
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 7),
                                            child: IconButton(
                                              onPressed: () async {
                                                if (await controller.onOpenSinger()) {
                                                  await onSuccess!.call();
                                                } else {
                                                  MyToast(tr('unverified_user'));
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.fingerprint_sharp,
                                                color: Color(0xff8B969A),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: InkWell(
                                      onTap: () {
                                        controller.onAddKeyboard(context, '0');
                                      },
                                      child: Text(
                                        tr('0'),
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
                                        if (controller.pinCode.isNotEmpty) {
                                          controller.deletePinCode();
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

                                  // Center(
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children:  [
                                  //     const MyImage(
                                  //       url: 'assets/images/registration/otpDelete.svg',
                                  //       height: 19,
                                  //       width: 25,
                                  //     ),
                                  //       Text(
                                  //         '0',
                                  //         style: TextStyle(
                                  //             color: AppColors.blackColor,
                                  //             fontSize: 32,
                                  //             fontFamily: 'Plain',
                                  //             fontWeight: FontWeight.w500
                                  //         ),
                                  //         textAlign: TextAlign.center,
                                  //       ),
                                  //       Text(
                                  //         '00',
                                  //         style: TextStyle(
                                  //             color: AppColors.blackColor,
                                  //             fontSize: 32,
                                  //             fontFamily: 'Plain',
                                  //             fontWeight: FontWeight.w500
                                  //         ),
                                  //         textAlign: TextAlign.center,
                                  //       )
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          )
                        ])),
            ),
          );
        }));
  }
}
