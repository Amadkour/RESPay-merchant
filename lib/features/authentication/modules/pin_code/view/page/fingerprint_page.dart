import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';

class FingerprintPage extends StatelessWidget {
  const FingerprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeCubit>.value(
      value: sl<PinCodeCubit>()..onIntBiomatricPage(),
      child: BlocBuilder<PinCodeCubit, PinCodeState>(
        builder: (BuildContext context, PinCodeState state) {
          final PinCodeCubit controller = context.read<PinCodeCubit>();
          return Scaffold(
            appBar: MainAppBar(
              title: tr('set_finger'),
              showBackButton: false,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.only(top: 30, bottom: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Builder(builder: (BuildContext context) {
                      if (state is PinCodeOnDoneWithBiometricsLoading) {
                        return const NativeLoading();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          AutoSizeText(
                            tr('active_fingerprint'),
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.blackColor,
                                fontFamily: 'Bold',
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              final bool authorized = await controller.onOpenSinger();
                              if (authorized) {
                                controller.onDoneWithBiometric();
                              } else {
                                MyToast(tr('unverified_user'));
                              }
                            },
                            child: Container(
                              height: 176,
                              width: 176,
                              decoration: BoxDecoration(
                                  color: AppColors.textColor3.withOpacity(0.1),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(35),
                                child: MyImage.svgAssets(
                                  url: 'assets/images/registration/Fingerprint.svg',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AutoSizeText(
                            tr('touch_sensor'),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textColor3,
                                fontFamily: 'Plain',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: LoadingButton(
                isLoading: state is PinCodeOnDoneLoading,
                title: tr('skip'),
                onTap: () {
                  controller.onDoneWithoutBiometric();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
