import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/features/search/view/page/search_page.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/components/promotions_list_widget.dart';

class PromotionsSearchScreen extends StatelessWidget {
  const PromotionsSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PromotionsCubit>.value(
      value: sl<PromotionsCubit>(),
      child: BlocBuilder<PromotionsCubit, PromotionsState>(builder: (BuildContext context, PromotionsState state) {
        final PromotionsCubit promotionsCubit = context.read<PromotionsCubit>();
        return PromotionsSearchBody(promotionsCubit: promotionsCubit);
      }),
    );
  }
}

class PromotionsSearchBody extends StatelessWidget {
  const PromotionsSearchBody({
    super.key,
    required this.promotionsCubit,
  });

  final PromotionsCubit promotionsCubit;

  @override
  Widget build(BuildContext context) {
    return SearchPage(
        onClear: () {
          promotionsCubit.resetSearchBar();
        },
        onChanged: (String v) {
          promotionsCubit.filter(v);
        },
        hint: "find_promotion",
        child: PromotionsListWidget(
          promotionsCubit: promotionsCubit,
          filteredPromotions: promotionsCubit.filteredPromotions,
        ));
  }
}
