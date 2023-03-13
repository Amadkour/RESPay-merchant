
import 'package:flutter_test/flutter_test.dart';
import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';


void main(){
  group('Schedule call test flow', () {
    testWidgets('test flow', (WidgetTester tester) async{
      await startApp(tester);

      await login(tester);

      await scheduleCall(tester);
    });
  });

}

Future<void> scheduleCall(WidgetTester tester)async{
  await goToBottomMoreIconAndOpenItem(scheduleFinder, tester, isLogin: true);

  /// Tap to select day
  await isPresent(selectDayFinder, tester);
  await tester.tap(selectDayFinder);
  await tester.pumpAndSettle();
  /// Tap to select time
  await isPresent(selectTimeFinder, tester);
  await tester.tap(selectTimeFinder);
  await tester.pumpAndSettle();
  /// Tap to set call
  await isPresent(setCallFinder, tester);
  await tester.tap(setCallFinder);
  await tester.pumpAndSettle();

  /// back to home

  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
  // await tester.tap(goBackToMore);
  // await tester.pumpAndSettle();



}
