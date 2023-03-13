import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/helper.dart';


Future<void> openScreen(
    {required WidgetTester tester, required Finder finder, String? screenName}) async {
  /// select screen from more screen
  debugPrint('========# select  $screenName screen started #=========');
  final Finder finderTest = await isPresent(finder, tester);
  await tester.tap(finderTest, warnIfMissed: false);
  await tester.pumpAndSettle();

  debugPrint('========# select $screenName screen ended #=========');
}
