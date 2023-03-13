import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/dialogs/error_dialog.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

void show400Dialog(DioError error) {
  CustomAlertDialog(
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('Bad request'),
      button1String: tr("Retry"),
      button1OnTap: () async {
        APIConnection.instance.dio.fetch(error.requestOptions);
        CustomNavigator.instance.maybePop();
      },
      button2String: tr('Cancel'),
      button2OnTap: () async {
        CustomNavigator.instance.maybePop();
      });
}

void show500Dialog(DioError error) {
  final APIConnection apiConnection = APIConnection();
  final String url = error.requestOptions.path
      .substring(error.requestOptions.baseUrl.length + 1);
  final Map<dynamic, dynamic> headers =
      Map<String, String>.from(error.requestOptions.headers);
  final Map<dynamic, dynamic> query =
      Map<String, String>.from(error.requestOptions.queryParameters);
  final String? contentType = error.requestOptions.contentType;
  final String method = error.requestOptions.method.toUpperCase();
  final dynamic body = error.requestOptions.data;

  CustomAlertDialog(
      title: tr('Server Error'),
      button1String: "Retry",
      button1OnTap: () async {
        CustomNavigator.instance.maybePop();
        if (method == 'GET') {
          await apiConnection.dio.get(
            url,
            options: Options(
              contentType: contentType,
              headers: headers as Map<String, String>,
            ),
            queryParameters: query as Map<String, dynamic>,
          );
        } else {
          await apiConnection.dio.post(
            url,
            data: body as FormData,
            options: Options(
              contentType: contentType,
              headers: headers as Map<String, String>,
            ),
            queryParameters: query as Map<String, dynamic>,
          );
        }
      },
      button2String: tr('tryLater'));
}

void show401Dialog() {
  CustomAlertDialog(
      isTwoButtons: false,
      button1String: '',
      button1OnTap: null,
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('Unauthorized'),
      button2String: tr('logout'),
      button2OnTap: () async {});
}

void show404Dialog() {
  try {
    CustomAlertDialog(
        alertIcon: Icon(
          Icons.logout,
          color: AppColors.primaryColor,
          size: 50,
        ),
        title: tr('Server Error'),
        isTwoButtons: false,
        button1String: '',
        button1OnTap: null,
        button2OnTap: () {
          CustomNavigator.instance.maybePop();
        },
        button2String: 'Cancel');
  } catch (e) {
    ///
  }
}

void showTimeOutDialog(DioError error) {
  CustomAlertDialog(
      alertIcon: Icon(
        Icons.logout,
        color: AppColors.primaryColor,
        size: 50,
      ),
      title: tr('internet'),
      button1String: tr("Retry"),
      button1OnTap: () async {
        await APIConnection().dio.fetch(error.requestOptions);
        CustomNavigator.instance.maybePop();
      },
      button2String: tr('Cancel'),
      button2OnTap: () async {
        CustomNavigator.instance.maybePop();
      });
}

void unauthorizedDialog(DioError error) {
  CustomSuccessDialog.instance.show(
    context: globalKey.currentContext,
    canClose: true,
    title: tr('unauthorized_user'),
    subTitle:
        tr('You are unauthorized, please login or sign up to use all features'),
    onPressedFirstButton: () async {
      await sl<LocalStorageService>().removeSession();
      CustomNavigator.instance.pushNamed(RoutesName.login);
    },
    onPressedSecondButton: () {},
    imageUrl: 'assets/images/home/guestDialog.svg',
    firstButtonText: tr('Login'),
    bottomWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Text(
          tr("Don't Have an Account?"),
          style: TextStyle(
            color: AppColors.textColor3,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () async {
            sl<LocalStorageService>().removeSession();
            CustomNavigator.instance.pushNamed(RoutesName.register);
          },
          child: Text(
            tr('Sign Up'),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
        ),
        const Spacer()
      ],
    ),
  );
}
