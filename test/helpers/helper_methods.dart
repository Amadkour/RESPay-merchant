import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> back(WidgetTester tester) async {
  final NavigatorState navigator = tester.state(find.byType(Navigator));
  navigator.pop();
  await tester.pump();
}
