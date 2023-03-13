import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/view/pages/profile_page.dart';
import 'package:res_pay_merchant/routes/router.dart';

import '../../../../integration_test/helper/helper.dart';
import '../../../../integration_test/shared/values.dart';
import '../../../core/global_mocks/set_up_test.dart';

@GenerateMocks(<Type>[ProfileCubit])
void main() {
  late ProfileCubit profileCubit;
  setUpAll(() {
    mockTest();
    profileCubit = sl<ProfileCubit>();
    when(profileCubit.state).thenReturn(ProfileInitial());
    when(profileCubit.isSaveBottomSheet).thenReturn(false);
    when(profileCubit.image).thenReturn(File("path"));
    when(profileCubit.profileModel).thenReturn(ProfileModel(
        fullName: "hussein hamed", email: "testyourmail@gmail.com"));
    when(profileCubit.isReadOnly).thenReturn(true);
    when(profileCubit.fullNameFocusNode).thenReturn(FocusNode());
    when(profileCubit.idFocusNode).thenReturn(FocusNode());
    when(profileCubit.birthFocusNode).thenReturn(FocusNode());
    when(profileCubit.phoneFocusNode).thenReturn(FocusNode());
    when(profileCubit.mailFocusNode).thenReturn(FocusNode());
    when(profileCubit.idError).thenReturn("idError");
    when(profileCubit.phoneError).thenReturn("phoneError");
    when(profileCubit.mailError).thenReturn("mailError");
    when(profileCubit.fullNameError).thenReturn("fullNameError");
    when(profileCubit.birthDateError).thenReturn("birthDateError");
    when(profileCubit.idNumberController)
        .thenReturn(TextEditingController(text: "434343423"));
    when(profileCubit.birthDateController)
        .thenReturn(TextEditingController(text: "2002-03-07"));
    when(profileCubit.fullNameController)
        .thenReturn(TextEditingController(text: "test name"));
    when(profileCubit.phoneNumberController)
        .thenReturn(TextEditingController(text: "5556667777"));
    when(profileCubit.emailController)
        .thenReturn(TextEditingController(text: "test@gmail.com"));
    final Stream<ProfileState> stream =
        Stream<ProfileState>.fromIterable(<ProfileState>[
      ProfileInitial(),
      ProfileUpdateLoading(),
      ProfileLoaded(),
    ]);
    when(profileCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
  });
  group('testing Profile screen', () {
    testWidgets('testing  Profile view In Edit Mode',
        (WidgetTester tester) async {
      await buildBody(tester, profileCubit);
      expect(
          find
              .widgetWithText(LoadingButton, tr("Edit Profile"))
              .evaluate()
              .toList()
              .length,
          1);
      expect(find.text(tr("Full Name")), findsOneWidget);
      expect(find.text(tr("ID Number")), findsOneWidget);
      expect(find.text(tr("Date Of Birth")), findsOneWidget);
      expect(find.text(tr("Date Of Birth")), findsOneWidget);
      expect(find.text(tr("Phone Number")), findsOneWidget);
      expect(find.text(tr("email")), findsOneWidget);
      expect(find.text("434343423"), findsOneWidget);
      expect(find.text("2002-03-07"), findsOneWidget);
      expect(find.text("test name"), findsOneWidget);
      expect(find.text("5556667777"), findsOneWidget);
      expect(find.text("test@gmail.com"), findsOneWidget);
      expect(find.text("hussein hamed"), findsOneWidget);
      expect(find.text("testyourmail@gmail.com"), findsOneWidget);
      await ensureWidgetIsVisible(tester, editProfileButtonFinder);
      await clickOnButton(tester, editProfileButtonFinder);
      await buildBody(tester, profileCubit);
      expect(
          find
              .widgetWithText(LoadingButton, tr("Edit Profile"))
              .evaluate()
              .toList()
              .length,
          2);
    });
    testWidgets('testing  Profile view In Save Mode',
        (WidgetTester tester) async {
      when(profileCubit.isSaveBottomSheet).thenReturn(true);
      await buildBody(tester, profileCubit);
      expect(
          find
              .widgetWithText(LoadingButton, tr("Edit Profile"))
              .evaluate()
              .toList()
              .length,
          2);
    });
  });
}

Future<void> buildBody(WidgetTester tester, ProfileCubit mockCardsCubit) async {
  await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<GlobalCubit>.value(
              value: sl<GlobalCubit>(),
            ),
          ],
          child:
              ProfilePage(profileValidationFormKey: GlobalKey<FormState>()))));
}
