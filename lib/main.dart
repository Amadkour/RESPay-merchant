import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/bloc_observer.dart';
import 'package:res_pay_merchant/core/res/theme/themes.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/routes/router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (type == 'test') {
    Bloc.observer = MyBlocObserver();
  }

  await setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: showDevicePreview,
      builder: (BuildContext context) => MaterialApp(
        navigatorKey: globalKey,
        title: 'RES Pay',
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        builder: showDevicePreview
            ? DevicePreview.appBuilder
            : (BuildContext context, Widget? child) =>
                ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, child!),
                  maxWidth: 1200,
                  minWidth: 250,
                  breakpoints: <ResponsiveBreakpoint>[
                    const ResponsiveBreakpoint.resize(450, name: MOBILE),
                    const ResponsiveBreakpoint.resize(800, name: TABLET),
                    const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                    const ResponsiveBreakpoint.resize(2460, name: "4K"),
                  ],
                ),
        theme: lightTheme,
        // initialRoute: startRoute,

        onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
        // initialRoute: startRoute,
        initialRoute: startRoute,
      ),
    );
  }
}
