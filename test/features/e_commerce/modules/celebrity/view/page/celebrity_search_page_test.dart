// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/page/celebrity_search_page.dart';

import '../../../../../../core/global_mocks/set_up_test.dart';
import '../../celebrity_values.dart';

void main() {
  late CelebrityCubit cubit;

  setUpAll(() {
    mockTest();
    cubit = sl<CelebrityCubit>();
  });
  testWidgets('celebrity search ', (WidgetTester tester) async {
    when(cubit.celebrityList).thenReturn(celebrities.celebrity!
        .where((element) => element.name == "Messi")
        .toList());
    await _buildScreen(tester);

    await tester.enterText(find.byKey(searchTextFieldKey), "Messi");
    await tester.pumpAndSettle();

    expect(tester.widgetList(find.byKey(celebrityWidgetKey)).length, 1);
  });

  testWidgets('test clean search', (WidgetTester tester) async {
    when(cubit.celebrityList).thenReturn(celebrities.celebrity!);
    await _buildScreen(tester);
    await tester.enterText(find.byKey(searchTextFieldKey), "M");
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(searchClearTextFieldButtonKey));
    await tester.pumpAndSettle();
    expect(tester.widgetList(find.byKey(celebrityWidgetKey)).length, 4);
  });
}

Future<void> _buildScreen(
  WidgetTester tester,
) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: CelebritySearchScreen(),
    ),
  );
}
