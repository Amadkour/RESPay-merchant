import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';

class CustomNavigator {
  CustomNavigator._singleTone();

  static final CustomNavigator _instance = CustomNavigator._singleTone();

  static CustomNavigator get instance => _instance;

  void pop({int numberOfPop = 1, dynamic result}) {
    for (int i = 0; i < numberOfPop; i++) {
      Navigator.pop(globalKey.currentContext!, result);
    }
  }

  void popWithoutAnimation({int numberOfPop = 1, required Widget routeWidget}) {
    for (int i = 0; i < numberOfPop; i++) {
      Navigator.pop(
          globalKey.currentContext!,
          PageRouteBuilder<dynamic>(
            pageBuilder: (BuildContext context, Animation<double> animation1,
                    Animation<double> animation2) =>
                routeWidget,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ));
    }
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return Navigator.pushNamed(globalKey.currentContext!, routeName,
        arguments: arguments);
  }

  void pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic> route) callback,
      {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        globalKey.currentContext!, routeName, callback,
        arguments: arguments);
  }

  void pushAndRemoveUntil({
    required Widget routeWidget,
    required bool Function(Route<dynamic> route) callback,
  }) {
    Navigator.pushAndRemoveUntil(globalKey.currentContext!,
        MaterialPageRoute<dynamic>(builder: (_) => routeWidget), callback);
  }

  void popAndPushNamed({required String routeName, Object? argument}) {
    Navigator.popAndPushNamed(globalKey.currentContext!, routeName,
        arguments: argument);
  }

  void pushReplacementNamed(String routeName, {Object? argument}) {
    Navigator.pushReplacementNamed(globalKey.currentContext!, routeName,
        arguments: argument);
  }

  void push({
    required Widget routeWidget,
  }) {
    Navigator.push(
      globalKey.currentContext!,
      MaterialPageRoute<dynamic>(builder: (_) => routeWidget),
    );
  }

  void maybePop() {
    Navigator.maybePop(globalKey.currentContext!);
  }

  void popUntil(bool Function(Route<dynamic> route) callback) {
    Navigator.popUntil(globalKey.currentContext!, callback);
  }

  void pushReplacementWithoutAnimations({
    required Widget routeWidget,
  }) {
    Navigator.pushReplacement(
        globalKey.currentContext!,
        PageRouteBuilder<dynamic>(
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              routeWidget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }
}
