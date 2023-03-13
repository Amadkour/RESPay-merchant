import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/about/controller/about_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutCubit>(
      create: (BuildContext context) => AboutCubit(TermPrivacyAboutRepository.instance),
      child: BlocBuilder<AboutCubit, AboutState>(
        builder: (BuildContext context, AboutState state) {
          final AboutCubit cubit = BlocProvider.of(context);

          if (state is AboutLoading) {
            return MainScaffold(
              scaffold: const NativeLoading(),
            );
          } else {
            return MainScaffold(
              appBarWidget: MainAppBar(title: tr('about_us')),
              scaffold: AboutScreen(cubit: cubit),
            );
          }
        },
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
    required this.cubit,
  });

  final AboutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            MyImage.assets(url: 'assets/images/more/about/about-icon.png'),
            const SizedBox(
              height: 16,
            ),
            AutoSizeText(
              cubit.aboutModels[0].title!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            AutoSizeText(
              cubit.aboutModels[0].description!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 16, color: const Color(0xff6B7480), height: 1.5),
              textAlign: TextAlign.center,
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
