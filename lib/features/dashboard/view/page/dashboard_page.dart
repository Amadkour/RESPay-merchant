import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/controller/cubit.dart';
import 'package:res_pay_merchant/features/dashboard/controller/state.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/page/home_view.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/page/more.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/view/page/shop_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_list_page.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';

class DashboardPage extends StatelessWidget {
  final bool isAuthorized;

  const DashboardPage({
    super.key,
    required this.isAuthorized,
  });

  @override
  Widget build(BuildContext context) {
    ///
    final Scaffold dashboard = Scaffold(
      body: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<DashboardCubit>(
            create: (BuildContext context) => DashboardCubit(),
          ),
          BlocProvider<TransactionHistoryCubit>.value(
            value: sl<TransactionHistoryCubit>(),
          ),
        ],
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (BuildContext context, DashboardState state) {
            final DashboardCubit controller = context.read<DashboardCubit>();
            return WillPopScope(
              child: MainScaffold(
                scaffold: Scaffold(
                  body: PageView(
                    controller: DashboardCubit.get(context).pageController,
                    onPageChanged: controller.bottomChanged,
                    children: <Widget>[
                      ///--------home
                      HomePage(
                        isAuthorized: isAuthorized,
                      ),

                      ///------Shop
                      ShopPage(),

                      ///--------celebrity
                      const CelebrityListPage(),

                      ///--------cart
                      MorePage(
                        isAuthorized: isAuthorized,
                      )
                    ],
                  ),
                  bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.15),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          child: BlocBuilder<GlobalCubit, GlobalState>(
                            builder: (BuildContext context, GlobalState state) {
                              return BottomNavigationBar(
                                backgroundColor: Colors.white,
                                onTap: controller.bottomChanged,
                                showSelectedLabels: true,
                                type: BottomNavigationBarType.fixed,
                                showUnselectedLabels: true,
                                currentIndex: controller.currentIndex,
                                items: List<BottomNavigationBarItem>.generate(
                                  controller.items.length,
                                  (int index) => BottomNavigationBarItem(
                                    activeIcon: MyImage.svgAssets(
                                      key: getDashboardIconKey(index),
                                      url:
                                          'assets/images/dashboard/active-${controller.items[index].image}.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    icon: MyImage.svgAssets(
                                      key: getDashboardIconKey(index),
                                      url:
                                          'assets/images/dashboard/${controller.items[index].image}.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    label: tr(controller.items[index].title),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (!isAuthorized)
                        ColoredBox(
                          color: AppColors.grayTextColor,
                          child: SafeArea(
                            top: false,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.grayTextColor,
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.blackColor)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MyImage.svgAssets(
                                    url:
                                        'assets/images/dashboard/guest_icon.svg',
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    tr('guest_mode'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              onWillPop: () async {
                if (controller.currentIndex != 0) {
                  controller.bottomChanged(0);
                }
                return false;
              },
            );
          },
        ),
      ),
    );
    return MainScaffold(scaffold: dashboard);
  }
}
