import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/controller/on_boarding_controller_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/view/component/onboarding_bottom_widget.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/view/component/onboarding_widget.dart';
class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingControllerCubit>(
      create: (BuildContext context) => OnBoardingControllerCubit(),
      child: BlocBuilder<OnBoardingControllerCubit, OnBoardingControllerState>(
        builder: (BuildContext context, OnBoardingControllerState state) {
          final OnBoardingControllerCubit cubit = BlocProvider.of(context);
          return MainScaffold(
            appBarWidget: const MainAppBar(
              height: 0,
            ),
            scaffold: Container(
              padding: EdgeInsets.only(
                  right: context.width * 0.05,
                  left: context.width * 0.05,
                  top: context.height * 0.075,
                  bottom: context.height * 0.055),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ///----------------------Progress bar ----------------------///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ...List<Widget>.generate(
                        3,
                        (int index) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AnimatedContainer(
                              width: context.width * 0.24,
                              height: context.height * 0.013,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              decoration: BoxDecoration(
                                  color: cubit.index == index
                                      ? AppColors.blackColor
                                      : AppColors.borderColor,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            SizedBox(
                              width: context.width * 0.03,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.06,
                  ),

                  ///----------------------PageView for images and text----------------------///
                  Expanded(
                    child: SizedBox(
                        width: context.width * 0.8,
                        child: PageView.builder(
                          itemCount: cubit.imageUrl.length,
                          onPageChanged: (int index) {
                            cubit.onChangeIndex(index);
                          },
                          itemBuilder: (BuildContext ctx, int index) {
                            return OnBoardingWidget(
                              imageUrl: cubit.imageUrl[index],
                              titleText: cubit.titleText[index],
                              firstText: cubit.firstText[index],
                            );
                          },
                        )),
                  ),

                  ///----------------------bottom text and buttons (Log In, Sign Up) ----------------------///
                  OnBoardingBottomWidget(
                    cubit: cubit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
