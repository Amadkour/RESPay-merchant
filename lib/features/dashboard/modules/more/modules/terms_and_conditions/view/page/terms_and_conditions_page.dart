import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/authentication/view/component/terms_privacy_item_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/controller/terms_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TermsCubit>(
      create: (BuildContext context) => TermsCubit(TermPrivacyAboutRepository.instance),
      child: BlocBuilder<TermsCubit, TermsState>(
        builder: (BuildContext context, TermsState state) {
          final TermsCubit cubit = BlocProvider.of(context);

          if (state is TermsLoading) {
            return MainScaffold(scaffold: const NativeLoading());
          } else {
            return MainScaffold(
              appBarWidget: MainAppBar(
                title: tr('terms_of_conditions'),
              ),
              scaffold: TermsAndConditionsBody(cubit: cubit),
            );
          }
        },
      ),
    );
  }
}

class TermsAndConditionsBody extends StatelessWidget {
  const TermsAndConditionsBody({
    super.key,
    required this.cubit,
  });

  final TermsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ...List<Widget>.generate(
            cubit.terms.length,
            (int index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                key: index == 0 ? termsListTileKey : null,
                onTap: () {
                  cubit.changeTermExpanded(index);
                },
                child: TermsPrivacyWidget(
                  termsPrivacyModel: cubit.terms[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
