import 'package:flutter_driver/flutter_driver.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:test/test.dart';

void main() {
  group("login testing", () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('should login with valid credentials', () async {
      await tap(driver, find.byValueKey(loginButtonKey));

      await type(driver, find.byValueKey(idControllerKey), '20222022');
      await type(driver, find.byValueKey(passwordControllerKey), 'Mobile@2022');

      await tap(driver, find.byValueKey(loginButtonKey));
    });
  });
}

Future<void> tap(FlutterDriver driver, SerializableFinder element) async {
  await driver.tap(element);
}

Future<void> type(
    FlutterDriver driver, SerializableFinder element, String text) async {
  await tap(driver, element);
  await driver.enterText(text);
}

Future<String> getText(FlutterDriver driver, SerializableFinder element) async {
  return driver.getText(element);
}
