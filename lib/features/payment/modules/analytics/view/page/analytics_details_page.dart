import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/chart/chart_container_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_category.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/analytic_category_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/analytics_tabbar.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/category_action_bottom_sheet_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/transaction_empty_state_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/transaction_list_widget.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class AnalyticsDetailsPage extends StatelessWidget {
  const AnalyticsDetailsPage({super.key, this.isAuthorized = true});

  final bool? isAuthorized;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: tr("analytics_details"),
      ),
      scaffold: SingleChildScrollView(
        child: BlocProvider<AnalyticsCubit>.value(
          value: sl<AnalyticsCubit>(
              instanceName: isAuthorized! ? "user" : 'guest'),
          child: Builder(builder: (BuildContext context) {
            final AnalyticsCubit analyticsCubit = sl<AnalyticsCubit>(
                instanceName: isAuthorized! ? "user" : 'guest');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //------Tab bar --------//
                const AnalyticsTabBarWidget(),
                //-------chart widget -----//
                BlocBuilder<AnalyticsCubit, AnalyticsState>(
                  buildWhen: (AnalyticsState previous, AnalyticsState current) {
                    return current is AnalyticsDurationChanged;
                  },
                  builder: (BuildContext context, AnalyticsState state) {
                    return ChartContainerWidget(
                      total: analyticsCubit.model?.total ?? 0,
                      data: analyticsCubit.model?.chart ?? <String, dynamic>{},
                      type: 'income',
                      duration: analyticsCubit.duration,
                      onDurationChanged: (String? v) {
                        analyticsCubit.changeDuration(v!);
                      },
                    );
                  },
                ),
                //----- category widget ------//
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 24,
                    bottom: 16,
                  ),
                  child: Text(
                    tr("category"),
                    style: paragraphStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                BlocBuilder<AnalyticsCubit, AnalyticsState>(
                  builder: (BuildContext context, AnalyticsState state) {
                    final AnalyticsCubit analyticCubit = sl<AnalyticsCubit>(
                        instanceName: isAuthorized! ? "user" : 'guest');
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 20,
                          children: List<Widget>.generate(
                                  analyticCubit.categories.length, (int index) {
                                final AnalyticsCategory category =
                                    analyticCubit.categories.elementAt(index);
                                return AnalyticsCategoryWidget(
                                  margin: EdgeInsets.zero,
                                  category: category,
                                  width: (context.width / 2) - 30,
                                  onPressed: () {
                                    showCustomBottomSheet(
                                      hasButtons: false,
                                      context: context,
                                      body: CategoryBottomSheetWidget(
                                        index: index,
                                        isAuthorized: isAuthorized!,
                                      ),
                                      title: "action_menu",
                                    );
                                  },
                                );
                              }) +
                              <Widget>[
                                InkWell(
                                  onTap: () {
                                    CustomNavigator.instance.pushNamed(
                                        RoutesName.addCategory,
                                        arguments: <String, dynamic>{
                                          "isAuthorized": isAuthorized
                                        });
                                  },
                                  child: DottedBorder(
                                    radius: const Radius.circular(16),
                                    borderType: BorderType.RRect,
                                    dashPattern: const <double>[8],
                                    color: AppColors.systemBodyColor
                                        .withOpacity(0.5),
                                    child: Container(
                                      height: 134,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      width: (context.width / 2) - 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: AppColors.blueColor,
                                            size: 30,
                                          ),
                                          Text(
                                            tr("add_new_category"),
                                            style: smallStyle.copyWith(
                                              color: AppColors.blueColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                        ),
                      ),
                    );
                  },
                ),

                //--------transaction widget -------//
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 24,
                    bottom: 16,
                  ),
                  child: Text(
                    tr("transactions"),
                    style: paragraphStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                BlocBuilder<AnalyticsCubit, AnalyticsState>(
                  builder: (BuildContext context, Object? state) {
                    final List<TransactionModel> list =
                        analyticsCubit.transactions;

                    if (state is TransactionHistoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (analyticsCubit.model?.transactions.isEmpty == true) {
                        return const TransactionEmptyStateWidget();
                      }
                      return Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: SearchTextfield(
                          //     onChanged: (String v) {
                          //       analyticsCubit.transactionSearch(v);
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SearchBar(
                              hintText: tr("Search Store or Product"),
                              onChanged: (String v) {
                                analyticsCubit.transactionSearch(v);
                              },
                              backGroundColor: Colors.white,
                              showClear: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: HistoryListWidget(
                              transactions: list,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
