import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_list_widget.dart';
import 'package:res_pay_merchant/features/search/view/page/search_page.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class CelebritySearchScreen extends StatelessWidget {
  const CelebritySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CelebrityCubit>.value(
        value: sl<CelebrityCubit>(),
        child: BlocBuilder<CelebrityCubit, CelebrityState>(
          builder: (BuildContext context, CelebrityState state) {
            final CelebrityCubit celebrityController =
                context.read<CelebrityCubit>();
            return SearchPage(
              onClear: () {
                celebrityController.resetSearchBar();
              },
              onChanged: (String v) {
                celebrityController.search(v);
              },
              hint: tr('find_celebrity'),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CelebrityListWidget(
                  celebrityController: celebrityController,
                ),
              ),
            );
          },
        ));
  }
}
