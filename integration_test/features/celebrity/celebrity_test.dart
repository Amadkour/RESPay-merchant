import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() {
  testWidgets("test celebrity flow", (WidgetTester tester) async {
    await celebrityFlow(tester);
  });
}

Future<void> celebrityFlow(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }

  await tester.tap(celebrityIconFinder);
  await tester.pumpAndSettle();

  //search
  await _searchFlow(tester);
  await _genderFilterFlow(tester);
  await _storiesViewFlow(tester);

  /// navigate back to home
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> deepCelebrityFlow(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }

  await tester.tap(celebrityIconFinder);
  await tester.pumpAndSettle();

  await _searchFlow(tester);
  await _genderFilterFlow(tester);
  await isPresent(celebrityWidgetFinder, tester);
  await tester.tap(celebrityWidgetFinder.first);
  await tester.pumpAndSettle();
  await _openFavouriteAndCartIconAndOpenProductDetails(tester);

  await _storiesViewFlow(tester);

  /// navigate back to home
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> _openFavouriteAndCartIconAndOpenProductDetails(WidgetTester tester) async {
  await tester.tap(firstProductItemFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(favouriteIconInAppBarFinder);
  await tester.pumpAndSettle();
  await tester.tap(cartIconInAppBarFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> _storiesViewFlow(WidgetTester tester) async {
  await tester.tap(storiesButtonFinder);
  await tester.pumpAndSettle();
  await isPresent(bookmarkedStoriesFinder, tester);
  await tester.tap(bookmarkedStoriesFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await isPresent(likedStoriesFinder, tester);
  await tester.tap(likedStoriesFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> _genderFilterFlow(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<CelebrityGender>(CelebrityGender.men)));
  await tester.pumpAndSettle();
}

Future<void> _searchFlow(WidgetTester tester) async {
  await tester.tap(celebritySearchInkwellFinder);
  await tester.pumpAndSettle();
  await tester.enterText(historySearchTextFieldFinder, "Celebrity-1");
  await tester.pumpAndSettle();
  await tester.tap(searchClearTextFieldButtonFinder);
  await tester.pumpAndSettle();
  await isPresent(celebrityWidgetFinder, tester);
  await tester.tap(celebrityWidgetFinder.first);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
}
