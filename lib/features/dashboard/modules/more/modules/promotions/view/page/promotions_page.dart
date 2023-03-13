import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/components/promotions_list_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: "promotions",
        actions: InkWell(
          key: searchIconKey,
          onTap: () {
            CustomNavigator.instance.pushNamed(RoutesName.promotionsSearch);
          },
          child: MyImage.svgAssets(
            url: "assets/icons/search.svg",
            width: 20,
            height: 20,
          ),
        ),
      ),
      scaffold: BlocProvider<PromotionsCubit>.value(
        value: sl<PromotionsCubit>()..getPromotions(),
        child: BlocBuilder<PromotionsCubit, PromotionsState>(
          builder: (BuildContext context, PromotionsState state) {
            if (state is PromotionsLoading) {
              return NativeLoading(
                size: context.height * 0.07,
              );
            }
            if (state is PromotionsError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                MyToast("Error Happen");
              });
              sl<PromotionsCubit>().resetState();
            }
            return PromotionsListWidget(
                promotionsCubit: sl<PromotionsCubit>(),
                filteredPromotions:
                    sl<PromotionsCubit>().promotionsModel!.promotions!.cast<SinglePromotion>());
          },
        ),
      ),
    );
  }
}
