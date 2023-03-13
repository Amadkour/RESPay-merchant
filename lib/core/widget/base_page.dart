import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class MainScaffold extends StatelessWidget with WidgetsBindingObserver {
  final Widget scaffold;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBarWidget;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  MainScaffold({
    super.key,
    required this.scaffold,
    this.floatingActionButton,
    this.appBarWidget,
    this.bottomNavigationBar,
    this.backgroundColor,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCubit>.value(
      value: sl<GlobalCubit>(),
      child: Builder(builder: (BuildContext context) {
        return BlocBuilder<GlobalCubit, GlobalState>(
          builder: (BuildContext context, GlobalState state) {
            return Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Material(
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(AppColors.lightWhite),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                    bottomNavigationBar: bottomNavigationBar,
                    floatingActionButton: floatingActionButton,
                    appBar: appBarWidget,
                    body: scaffold,
                    backgroundColor: backgroundColor,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  static DateTime _backgroundTime = DateTime.now();
  static AppLifecycleState? _state;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_state != state) {
      _state = state;

      ///--------------foreground
      if (state == AppLifecycleState.resumed) {
        /// To ensure login
        if (await sl<FlutterSecureStorage>().containsKey(key: userToken) &&

                /// To ensure threshold 25s
                DateTime.now().difference(_backgroundTime).inSeconds > 25 &&

                /// To ensure secureCode configuration
                await sl<FlutterSecureStorage>()
                    .containsKey(key: userPinCode) &&
                !isLocalAuth

            /// To ensure in non configuration page
            ) {
          if (type != 'integration test') {
            CustomNavigator.instance
                .pushNamed(RoutesName.pinCodeWithoutAnimation);
          }
        }

        ///--------------background
        _backgroundTime = DateTime.now();
      } else if (state == AppLifecycleState.paused) {
        _backgroundTime = DateTime.now();
      }
      super.didChangeAppLifecycleState(state);
    }
  }
}

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  bool canRefresh = false;

  Future<void> onRefresh();
}
