import 'package:flutter_test/flutter_test.dart';

import '../helper/helper.dart';

Future<void> scroll(
    {required WidgetTester tester, required Finder finder, required double double}) async {
  final Finder finderScroll = await isPresent(finder, tester);
  await tester.drag(finderScroll, Offset(0, double));
  await tester.pump();
}
