import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/extensions/hex_color_extension.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/button/clickable_container.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/core/widget/text_field/validator/child/name_validator.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/controller/analytics_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/color_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/category/controller/cubit/category_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/model/category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/category/view/component/category_list_sheet.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage(
      {super.key, required this.index, this.isAuthorized = true});

  final int? index;
  final bool? isAuthorized;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: const MainAppBar(
        title: 'create_new_category',
      ),
      scaffold: Scaffold(
        body: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<CategoryCubit>.value(
              value: sl<CategoryCubit>(),
            ),
            BlocProvider<AnalyticsCubit>.value(
              value: sl<AnalyticsCubit>(
                  instanceName: isAuthorized! ? "user" : 'guest'),
            ),
          ],
          child: Builder(builder: (BuildContext context) {
            final AnalyticsCubit analyticsCubit = sl<AnalyticsCubit>(
                instanceName: isAuthorized! ? "user" : 'guest');
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 24, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    //-------category sample widget------//
                    Container(
                      width: 200,
                      padding: const EdgeInsetsDirectional.only(
                          start: 16, top: 16, bottom: 16, end: 63),
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 33,
                            color: Color.fromRGBO(38, 38, 38, 0.1),
                          )
                        ],
                      ),
                      child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
                        builder: (BuildContext context, AnalyticsState state) =>
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                // decoration: BoxDecoration(
                                //   color: analyticsCubit.color == null
                                //       ? AppColors.blueColor.withOpacity(0.2)
                                //       : analyticsCubit.color!.withOpacity(0.2),
                                //   shape: BoxShape.circle,
                                // ),
                                padding: const EdgeInsets.all(8),
                                child: analyticsCubit.icon != null
                                    ? MyImage.svgAssets(
                                        url: analyticsCubit.icon,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        color: analyticsCubit.color == null
                                            ? AppColors.blueColor
                                                .withOpacity(0.2)
                                            : analyticsCubit.color!
                                                .withOpacity(0.2),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blueColor,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: const Icon(
                                          Icons.question_mark_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      )),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                analyticsCubit.name == null ||
                                        analyticsCubit.name?.isEmpty == true
                                    ? tr("category_name")
                                    : analyticsCubit.name!,
                              ),
                            ),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: "0.000.00",
                                style: paragraphStyle,
                              ),
                              TextSpan(
                                text: " ${tr('sar')}",
                                style: smallStyle,
                              )
                            ])),
                          ],
                        ),
                      ),
                    ),
                    //-------colors widget------//
                    Padding(
                      padding: const EdgeInsets.only(top: 27, bottom: 45),
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (BuildContext context, CategoryState state) {
                          final CategoryCubit categoryCubit =
                              context.read<CategoryCubit>();
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
                              builder:
                                  (BuildContext context, AnalyticsState state) {
                                return ColorWidget(
                                  onColorSelected: (String v) {
                                    analyticsCubit.setColor(v.toColor());
                                  },
                                  selectedColor: analyticsCubit.color?.toHex(),
                                  colors: categoryCubit.categories.length > 8
                                      ? categoryCubit.categories
                                          .sublist(0, 8)
                                          .map((CategoryModel e) =>
                                              e.color.toHex())
                                          .toList()
                                      : categoryCubit.categories
                                          .map((CategoryModel e) =>
                                              e.color.toHex())
                                          .toList(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    ///category icon widget
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ClickableContainer(
                        onPressed: () {
                          showCustomBottomSheet(
                            context: context,
                            body: CategoryListSheet(
                              onIconChanged: (CategoryModel v) {
                                analyticsCubit.setIcon(v.icon);
                              },
                            ),
                            title: 'select_category',
                          );
                        },
                        title: "select_icon",
                        value: tr("icon_style"),
                      ),
                    ),

                    //-------category name widget------//
                    ParentTextField(
                      defaultValue: analyticsCubit.name,
                      validator: NameValidator().getValidation(),
                      onChanged: (String v) {
                        analyticsCubit.setName(v);
                      },
                      title: tr('category_name'),
                      hint: tr("put_name"),
                      fillColor: AppColors.backgroundColor,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: BlocProvider<AnalyticsCubit>.value(
            value: sl<AnalyticsCubit>(
                instanceName: isAuthorized! ? "user" : 'guest'),
            child: BlocConsumer<AnalyticsCubit, AnalyticsState>(
              listener: (BuildContext context, AnalyticsState state) {
                if (state is AnalyticsCategoryUpdated) {
                  MyToast(
                    tr(index == null ? 'category_added' : "category_updated"),
                    background: AppColors.greenColor,
                  );

                  CustomNavigator.instance.pop();
                }
              },
              builder: (BuildContext context, AnalyticsState state) {
                final AnalyticsCubit analyticsCubit = sl<AnalyticsCubit>(
                    instanceName: isAuthorized! ? "user" : 'guest');
                return LoadingButton(
                  isLoading: analyticsCubit.state is AnalyticsCategoryLoading,
                  title:
                      tr(index != null ? 'edit_category' : 'create_category'),
                  onTap: () {
                    if (index == null) {
                      analyticsCubit.addCategory();
                    } else {
                      analyticsCubit.editCategory(index!);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
