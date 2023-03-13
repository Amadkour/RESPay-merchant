import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/dialogs/guest_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_state.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/items_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/upper_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/user_info_card.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/page/schedule_call.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key, required this.isAuthorized});

  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    final Widget topSetting = Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(12),
          child: InkWell(
              key: scheduleKey,
              onTap: () {
                scheduleCallBottomSheet(context);
              },
              child: SvgPicture.asset("assets/icons/more/policy.svg", width: 20, height: 20)),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          child: InkWell(
              key: settingKey,
              onTap: () {
                CustomNavigator.instance.pushNamed(RoutesName.settings);
              },
              child: SvgPicture.asset(
                "assets/icons/more/settings.svg",
                width: 24,
                height: 24,
              )),
        ),
      ],
    );
    return BlocProvider<MoreCubit>.value(
      value: sl<MoreCubit>(),
      child: BlocBuilder<MoreCubit, MoreState>(
        builder: (BuildContext context, MoreState state) => MainScaffold(
            appBarWidget: MainAppBar(
              title: "More",
              backgroundColor: AppColors.backgroundColor,
              showBackButton: false,
              actions: isAuthorized ? topSetting : GuestDialog(child: topSetting),
            ),
            scaffold: BlocProvider<MoreCubit>.value(
              value: sl<MoreCubit>(),
              child: BlocBuilder<MoreCubit, MoreState>(
                builder: (BuildContext context, MoreState state) {
                  if (state is SessionRemoved) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      /// add these methods to reset dependencies again when login
                      await sl.reset();
                      await setUp();
                      CustomNavigator.instance.pushReplacementNamed(RoutesName.login);
                    });
                    sl<MoreCubit>().resetStateAfterNavigate();
                  }
                  if (state is MoreLoadingState) {
                    return const NativeLoading();
                  } else {
                    return Container(
                      color: AppColors.backgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: SingleChildScrollView(
                        key: moreListKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BlocProvider<ProfileCubit>.value(
                              value: sl<ProfileCubit>()..init(),
                              child: BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (BuildContext context, ProfileState state) {
                                  return context.watch<ProfileCubit>().profileModel != null
                                      ? UserInfoCard(
                                          profileModel: context.watch<ProfileCubit>().profileModel!,
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (sl<MoreCubit>().upperList!.isEmpty)
                              EmptyWidget(
                                message: tr("No Items Yet"),
                                height: 0,
                              )
                            else
                              isAuthorized
                                  ? UpperList(list: sl<MoreCubit>().upperList!)
                                  : GuestDialog(child: UpperList(list: sl<MoreCubit>().upperList!)),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(tr("Account"),
                                style: const TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 12,
                            ),
                            ListOfItems(
                                items: sl<MoreCubit>().accountItems!, isAuthorized: isAuthorized),
                            Text(tr("Help"),
                                style: const TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 12,
                            ),
                            ListOfItems(
                              items: sl<MoreCubit>().helpItems!,
                            ),
                            Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: SizedBox(
                                  height: 48,
                                  width: context.width - 30,
                                  child: ElevatedButton(
                                    key: logoutButtonKey,
                                    onPressed: () async {
                                      ConfirmCancelDialog(
                                          context: context,
                                          title: tr("are_you_sure_you_want_to_log_out_account?"),
                                          onConfirm: () async {
                                            final String language =
                                                sl<LocalStorageService>().readString('lang');

                                            sl<CartCubit>().resetCartAndPromoCode();
                                            sl<FavoriteCubit>().resetFavorite();
                                            await sl<MoreCubit>().deleteSession();
                                            await sl<LocalStorageService>()
                                                .writeKey('lang', language);
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: defaultBorderRadius, // <-- Radius
                                        ),
                                        backgroundColor: AppColors.blackColor),
                                    child: Text(
                                      tr(isAuthorized ? "logout" : "login"),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            )),
      ),
    );
  }
}
