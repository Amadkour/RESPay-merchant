// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_filter_chip_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_list/celebrity_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_detail_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_list_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_search_page.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import '../../../../../../core/global_mocks/set_up_test.dart';
import '../../celebrity_values.dart';

void main() {
  late CelebrityCubit cubit;

  setUpAll(() {
    mockTest();
    cubit = sl<CelebrityCubit>();
  });

  group('testing celebrity gender filter', () {
    testWidgets('testing men view', (WidgetTester tester) async {
      when(cubit.celebrityList).thenReturn(celebrities.celebrity!);
      when(cubit.genderFilter).thenReturn(CelebrityGender.men);
      await _buildScreen(tester);

      expect(find.byKey(celebritySearchInkwell), findsOneWidget);
      expect(tester.widgetList(find.bySubtype<CelebrityWidget>()).length, 4);
    });

    testWidgets('testing women view', (WidgetTester tester) async {
      when(cubit.celebrityList).thenReturn(celebrities.celebrity!
          .where((Celebrity element) => element.gender == CelebrityGender.women)
          .toList());
      when(cubit.genderFilter).thenReturn(CelebrityGender.women);
      await _buildScreen(tester);
      final womenFinder = find.byKey(const ValueKey(CelebrityGender.women));
      await tester.tap(womenFinder);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.widgetList(find.bySubtype<CelebrityWidget>()).length, 0);

      await tester.pumpAndSettle();
      expect((tester.firstWidget(womenFinder) as CelebrityFilterChip).active,
          true);
    });

    testWidgets('testing all celebrities view', (WidgetTester tester) async {
      when(cubit.celebrityList).thenReturn(celebrities.celebrity!);
      when(cubit.genderFilter).thenReturn(CelebrityGender.allCelebrity);
      await _buildScreen(tester);
      final allFinder =
          find.byKey(const ValueKey(CelebrityGender.allCelebrity));
      await tester.tap(allFinder);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.widgetList(find.bySubtype<CelebrityWidget>()).length, 4);

      await tester.pumpAndSettle();
      expect(
          (tester.firstWidget(allFinder) as CelebrityFilterChip).active, true);
    });

    testWidgets('navigate to search screen', (WidgetTester tester) async {
      when(cubit.celebrityList).thenReturn(celebrities.celebrity!);
      when(cubit.genderFilter).thenReturn(CelebrityGender.allCelebrity);
      await _buildScreen(tester);

      await tester.tap(find.byKey(celebritySearchInkwell));
      await tester.pumpAndSettle();

      expect(find.byType(CelebritySearchScreen), findsOneWidget);
    });

    testWidgets('testing choose celebrity', (tester) async {
      when(cubit.celebrityList).thenReturn(celebrities.celebrity!);
      when(cubit.genderFilter).thenReturn(CelebrityGender.allCelebrity);
      when(cubit.banners).thenReturn([]);

      await _buildScreen(tester);
      final celebrityWidgetFinder = find.byKey(celebrityWidgetKey);
      await tester.tap(celebrityWidgetFinder.first);
      await tester.pumpAndSettle();
      expect(find.byType(CelebrityDetail), findsOneWidget);
    });
  });
}

Future<void> _buildScreen(WidgetTester tester) async {
  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(MaterialApp(
      navigatorKey: globalKey,
      onGenerateRoute: (settings) {
        if (settings.name == RoutesName.celebritySearch) {
          return MaterialPageRoute(
            builder: (context) => const CelebritySearchScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (context) => CelebrityDetail(
            currentCelebrity: settings.arguments! as Celebrity,
          ),
        );
      },
      home: Builder(builder: (BuildContext context) {
        return const CelebrityListPage();
      }),
    ));
  });
}
