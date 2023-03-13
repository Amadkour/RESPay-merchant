import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';

import '../features/authentication/login/login_test.dart';
import '../shared/values.dart';
import '../start_app_test.dart';

String pinCode = '1111';

Future<Finder> isPresent(dynamic input, WidgetTester tester,
    {int duration = 10}) async {
  final Finder finder = input is Finder
      ? input
      : find.byKey(
          input as Key,
        );
  final Stopwatch timer = Stopwatch();
  timer.start();
  while (finder.evaluate().isEmpty) {
    await tester.pumpAndSettle();
    if (timer.elapsed.inSeconds > duration) {
      timer.stop();
      break;
    }
  }
  return finder;
}

Future<void> scroll(WidgetTester tester, Finder item, Finder scroller,
    {bool scrollDown = true, bool tapping = true, double? offset}) async {
  await tester.dragUntilVisible(
      item, scroller, Offset(0, scrollDown ? offset ?? -20 : offset ?? 20),
      maxIteration: 1000);
  await tester.pump(const Duration(seconds: 3));
  if (tapping) {
    try {
      await tester.tap(item, warnIfMissed: false);
    } catch (e) {
      await tester.tap(item, warnIfMissed: false);
    }
  }
  await tester.pumpAndSettle();
}

Future<void> openTab(
    {required WidgetTester tester,
    required Finder finder,
    required String tabName}) async {
  debugPrint('========#  open $tabName tab started  #=========');
  // await isPresent(navigationButton, tester);
  final Finder finderTab = await isPresent(finder, tester);
  await tester.tap(finderTab);
  debugPrint('========#  open $tabName tab ended  #=========');
}

Future<void> tapMoreFinder(Finder finder, WidgetTester tester,
    {bool startFromInitApp = true}) async {
  if (startFromInitApp) {
    await startApp(tester);
    await login(tester);
    await tester.pumpAndSettle();
  }

  /// tap on more button in home screen
  await tester.tap(datasheetFinder);
  await tester.pumpAndSettle();

  /// tap to more finder
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> tapMoreAfterLogin(WidgetTester tester, Finder finder) async {
  /// tap on more button in home screen
  await tester.tap(datasheetFinder);
  await tester.pumpAndSettle();

  /// tap to more finder
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Back for previous screen
Future<void> back(WidgetTester tester) async {
  final NavigatorState navigator = tester.state(find.byType(Navigator));
  navigator.pop();
  await tester.pump();
}

Future<void> goToBottomMoreIconAndOpenItem(Finder finder, WidgetTester tester,
    {bool isLogin = false}) async {
  if (!isLogin) {
    await startApp(tester);
    await login(tester);
  }

  /// tap on more icon
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

  /// scroll and tap on Terms and conditions
  await scroll(tester, finder, moreListFinder);
}

Future<void> clickOnButton(WidgetTester tester, Finder finder,
    {bool warn = true}) async {
  await isPresent(finder, tester);
  await tester.tap(finder, warnIfMissed: warn);
  await tester.pumpAndSettle();
}

Future<void> fillTextField(
    WidgetTester tester, Finder targetTextField, String value) async {
  await tester.enterText(targetTextField, '');
  await tester.enterText(targetTextField, value);
  await tester.pumpAndSettle();
}

Future<void> selectFromDropDownList(WidgetTester tester,
    Finder selectedItemFinder, Finder dropDownFinder) async {
  await ensureWidgetIsVisible(tester, dropDownFinder);
  await clickOnButton(tester, dropDownFinder);
  await clickOnButton(tester, selectedItemFinder);
}

Future<void> ensureWidgetIsVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

int generateRandomNumber(int min, int max) => min + Random().nextInt(max - min);

///write pin code/otp
Future<void> writeCode(WidgetTester tester, {String? code}) async {
  // code ??= (await readSecureKey(userPinCode))!;
  code ??= (await sl<LocalStorageService>().getUserPinCode)!;
  for (int i = 0; i < code.length; i++) {
    // await tester.tap(find.text(Key("pin_code_${tr(code[i])}")));
    await tester.tap(find.text(tr(code[i])).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
}

/// wait until
Future<void> waitUntilVisible(
    WidgetTester tester, Finder viewEReceiptFinder) async {
  while (!tester.any(viewEReceiptFinder)) {
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
}

/// Delete the SnackBar from the ui
Future<void> deleteSnackBar(WidgetTester tester) async {
  ScaffoldMessenger.of(globalKey.currentContext!).removeCurrentSnackBar();
  await tester.pumpAndSettle();
}

bool findTextAndTap(InlineSpan visitor, String text) {
  if (visitor is TextSpan && visitor.text == text) {
    (visitor.recognizer! as TapGestureRecognizer).onTap!();
    return false;
  }
  return true;
}

bool tapTextSpan(RichText richText, String text) =>
    !richText.text.visitChildren(
      (InlineSpan visitor) => findTextAndTap(visitor, text),
    );
bool isValid(WidgetTester tester, String validation) {
  final Iterable<Widget> validationMessage =
      tester.widgetList(find.text(validation));
  return validationMessage.isEmpty;
}
