import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_widget.dart';

class CelebrityListWidget extends StatelessWidget {
  const CelebrityListWidget({
    super.key,
    required this.celebrityController,
  });

  final CelebrityCubit celebrityController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CelebrityCubit, CelebrityState>(
      builder: (BuildContext context, CelebrityState state) {
        if (state is CelebrityLoading) {
          return const NativeLoading();
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isTablet ? 3 : 2,
            childAspectRatio: 0.8,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: celebrityController.celebrityList.length,
          itemBuilder: (BuildContext context, int index) {
            final Celebrity celebrity = celebrityController.celebrityList.elementAt(index);
            return CelebrityWidget(
              
              celebrity: celebrity,
            );
          },
        );
      },
    );
  }
}
