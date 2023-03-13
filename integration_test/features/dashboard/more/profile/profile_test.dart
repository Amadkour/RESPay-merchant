import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test profile flow ", () {
    testWidgets('test profile flow', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await profileFlow(tester);
    });
  });
}

Future<void> profileFlow(WidgetTester tester,
    {bool changePhoneNumber = false}) async {
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

  /// tap on profile info button
  await clickOnButton(tester, goToProfileInfoButtonFinder);

  /// tap on edit profile button
  await ensureWidgetIsVisible(tester, editProfileButtonFinder);
  await clickOnButton(tester, editProfileButtonFinder);

  /// tap on cancel profile button
  await ensureWidgetIsVisible(tester, cancelProfileButtonFinder);
  await clickOnButton(tester, cancelProfileButtonFinder);

  /// tap on edit profile button
  await ensureWidgetIsVisible(tester, editProfileButtonFinder);
  await clickOnButton(tester, editProfileButtonFinder);

  ///tap on profile image
  await ensureWidgetIsVisible(tester, changeProfileImageButtonFinder);
  await clickOnButton(tester, changeProfileImageButtonFinder);

  /// tap on camera icon to take a photo
  await ensureWidgetIsVisible(tester, cameraIconButtonFinder);
  await clickOnButton(tester, cameraIconButtonFinder);
  await Future<void>.delayed(const Duration(seconds: 20));

  /// change first name
  await fillTextField(tester, profileFullNameTextFieldFinder,
      "Mohamed${generateRandomNumber(1000, 9999)}");

  /// change birth date
  await fillTextField(tester, profileBirthDateTextFieldFinder, "2000-02-02");

  /// change phone number
  if (changePhoneNumber) {
    final String newPhoneNumber =
        '05${generateRandomNumber(10000000, 99999999)}';
    await fillTextField(
        tester, profilePhoneNumberTextFieldFinder, newPhoneNumber);
  }

  /// tap on save changes button
  await ensureWidgetIsVisible(tester, saveChangesProfileButtonFinder);
  await clickOnButton(tester, saveChangesProfileButtonFinder);
  if (sl<ProfileCubit>().profileModel!.phoneNumber !=
      sl<ProfileCubit>().phoneNumberController.text) {
    final String? verifyPiCode = await sl<LocalStorageService>()
        .readSecureKey("verify_account_pin_code");
    await writeCode(tester, code: verifyPiCode);
    await tester.pumpAndSettle();
  }
  await tester.pumpAndSettle(const Duration(seconds: 4));
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> profileDeepTest(WidgetTester tester) async {
  await profileFlow(tester);
  await profileFlow(tester, changePhoneNumber: true);
}
