import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/authentication/view/component/terms_privacy_item_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/privacy/controller/privacy_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivacyCubit>(
      create: (BuildContext context) => PrivacyCubit(TermPrivacyAboutRepository.instance),
      child: BlocBuilder<PrivacyCubit, PrivacyState>(
        builder: (BuildContext context, PrivacyState state) {
          final PrivacyCubit cubit = BlocProvider.of(context);
          if (state is PrivacyLoading) {
            return MainScaffold(scaffold: const NativeLoading());
          } else {
            return MainScaffold(
              appBarWidget: MainAppBar(
                title: tr('privacy_policy'),
              ),
              scaffold: PrivacyPageBody(cubit: cubit),
            );
          }
        },
      ),
    );
  }
}

class PrivacyPageBody extends StatelessWidget {
  const PrivacyPageBody({
    super.key,
    required this.cubit,
  });

  final PrivacyCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ...List<Widget>.generate(
            cubit.privacyModels.length,
            (int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                key: index == 0 ? privacyListTileKey : null,
                onTap: () {
                  cubit.changePrivacyExpanded(index);
                },
                child: TermsPrivacyWidget(
                  termsPrivacyModel: cubit.privacyModels[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
