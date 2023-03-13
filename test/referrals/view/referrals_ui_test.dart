import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/model/referrals.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/contact_icon.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/invite_friend.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/single_referral_user.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/pages/referral_page.dart';
import 'package:res_pay_merchant/routes/router.dart';

import '../../../integration_test/shared/values.dart';
import '../../core/global_mocks/set_up_test.dart';

@GenerateMocks(<Type>[ReferralCubit])
void main() {
  late ReferralCubit referralCubit;
  setUpAll(() {
    mockTest();
    referralCubit = sl<ReferralCubit>();
    when(referralCubit.state).thenReturn(ReferralInitial());
    when(referralCubit.sunOfEarned).thenReturn(0);
    when(referralCubit.referral).thenReturn(ReferralModel(
        links: <String, dynamic>{
          "link 1": "link 1",
          "link 2": "link 2",
          "link 3": "link 3",
          "link 4": "link 4",
        },
        refCode: "234234sdfsfsf",
        referrals: <Referrals>[
          Referrals(
            refCode: "123123213dsds",
          )
        ]));
    final Stream<ReferralState> stream =
        Stream<ReferralState>.fromIterable(<ReferralState>[
      ReferralInitial(),
      ReferralLoading(),
      ReferralLoaded(),
    ]);
    when(referralCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
  });
  group('testing Referrals screen', () {
    testWidgets('testing  Referrals view', (WidgetTester tester) async {
      await buildBody(tester, referralCubit);
      expect(find.byType(TabBar), findsOneWidget);
      expect(
          find
              .widgetWithText(Tab, tr("Invite Friend"))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find.widgetWithText(Tab, tr("Referrals")).evaluate().toList().length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('Invite Friend Use Res Pay'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  tr('Maximize your monthly earnings by inviting your friends to the app. We have a lot of advantages in our referral program'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('Your Referral Code'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, referralCubit.referral!.refCode!)
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr("or invite via"))
              .evaluate()
              .toList()
              .length,
          1);
      expect(tester.widgetList(find.byType(ContactIcon)).length, 4);
      await tester.tap(referralsTapFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(tester.widgetList(find.byType(SingleReferralUser)).length, 1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  referralCubit.referral!.referrals!.first.fullName ?? "")
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr("User"))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, "${tr("Earn")} 0")
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(
                  AutoSizeText, referralCubit.sunOfEarned.toString())
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr("Raial"))
              .evaluate()
              .toList()
              .length,
          1);
    });
    testWidgets('testing  Bottom Sheet Body view', (WidgetTester tester) async {
      await buildReferralBottomSheetBody(tester, referralCubit);
      expect(tester.widgetList(find.byType(SingleSocialMediaLink)).length, 4);
    });
  });
}

Future<void> buildBody(
    WidgetTester tester, ReferralCubit mockCardsCubit) async {
  await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
        BlocProvider<GlobalCubit>.value(
          value: sl<GlobalCubit>(),
        ),
      ], child: const ReferralPage())));
}

Future<void> buildReferralBottomSheetBody(
    WidgetTester tester, ReferralCubit mockCardsCubit) async {
  await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
        BlocProvider<GlobalCubit>.value(
          value: sl<GlobalCubit>(),
        ),
      ], child: const InviteFriendBottomSheetBody())));
}
