import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/general_add_new_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/analytic_category_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class AnalyticsWidget extends StatelessWidget {
  const AnalyticsWidget({super.key, this.isAuthorized = true});

  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyticsCubit>.value(
        value:
            sl<AnalyticsCubit>(instanceName: isAuthorized ? "user" : 'guest'),
        child: BlocBuilder<HomCubit, HomeState>(
            builder: (BuildContext context, HomeState state) {
          final AnalyticsCubit analyticsCubit = context.read<AnalyticsCubit>();
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText(
                    tr('Manage Analytics'),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontFamily: 'Bold',
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      CustomNavigator.instance.pushNamed(
                          RoutesName.analyticsDetails,
                          arguments: isAuthorized);
                    },
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                          tr('view Details'),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff2C64E3),
                              fontFamily: 'Bold',
                              fontWeight: FontWeight.w500),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xff2C64E3),
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 145,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(
                      context.watch<AnalyticsCubit>().categories.length,
                      (int index) => AnalyticsCategoryWidget(
                        category: analyticsCubit.categories[index],
                      ),
                    )..add(GeneralAddNewWidget(
                        title: tr("add_new_category"),
                        onPressed: () {
                          CustomNavigator.instance.pushNamed(
                            RoutesName.addCategory,
                            arguments: <String, dynamic>{"isAuthorized": true},
                          );
                        },
                      )),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
