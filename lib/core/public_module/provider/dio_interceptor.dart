import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/dialogs/api_error_dialogs.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class DioInterceptor extends Interceptor {
  List<Future<void> Function()> repeating = <Future<void> Function()>[];

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    final DioErrorType errorType = err.type;

    try {
      if (<DioErrorType>[DioErrorType.response].contains(errorType)) {
        await _handleDialogError(err, handler);
        handler.resolve(err.response!);
        // handler.next(err);
      } else if (<DioErrorType>[DioErrorType.other].contains(errorType)) {
        throw SocketException(err.error.toString());
      } else {
        ///timeout
        MyToast('timeout$errorType');
        onResumeNetworkError(handler, err);
      }
    } on SocketException catch (e) {
      MyToast(e.message);
      log(e.message);
      onResumeNetworkError(handler, err);
    } catch (e) {
      MyToast(e.toString());
      rethrow;
    }
    // super.onError(err, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    if (data['code'] == 1022 &&
        (data['data'] as Map<String, dynamic>)['message'] ==
            "User Account Not Verified, verify your account first!") {
      MyToast(
          ((data['data'] as Map<String, dynamic>)['otp'] as int).toString());
      sl<LocalStorageService>().writeSecureKey("verify_account_pin_code",
          ((data['data'] as Map<String, dynamic>)['otp'] as int).toString());
      unverifiedOnResponse(response.requestOptions, handler);
    } else if ((data['data'] as Map<String, dynamic>)
        .containsKey('confirmation_code')) {
      final String otp =
          (data['data'] as Map<String, dynamic>)['confirmation_code'] as String;
      MyToast(otp);

      CustomNavigator.instance.pushNamed(
        verificationMethodPath,
        arguments: (String? confirmationCode) async {
          await _repeatOnResponse(
            handler,
            response.requestOptions.copyWith(
              data: (response.requestOptions.data as FormData)
                ..fields.add(
                  MapEntry<String, String>(
                      'confirmation_code', confirmationCode ?? ""),
                ),
            ),
          );
        },
      );

      return;
    }
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = <String, String>{
      'Accept': 'application/json',
      'Accept-Language': loggedInUser.locale ?? 'en',
      "user_uuid": loggedInUser.uuid ?? "",
      "Authorization": "Bearer ${loggedInUser.token}"
    };
    if (options.method == 'GET') {
      options.queryParameters
          .addAll(<String, dynamic>{"user_uuid": loggedInUser.uuid});
    }
    //TODO should remove in production
    if (options.method.toUpperCase() == "POST" &&
        loggedInUser.uuid != null &&
        options.data is Map<String, dynamic>) {
      (options.data as Map<String, dynamic>)['user_uuid'] = loggedInUser.uuid;
    }
    if (options.method.toUpperCase() == "POST" &&
        loggedInUser.uuid != null &&
        options.data is FormData) {
      final FormData map = options.data as FormData;
      map.fields
          .add(MapEntry<String, String>("user_uuid", loggedInUser.uuid ?? ''));

      options.data = map;
    }

    return handler.next(options);
  }

  Future<void> unverifiedOnResponse(
      RequestOptions requestOptions, ResponseInterceptorHandler handler) async {
    final String? alreadyOpened = await isOtpScreenAlreadyOpened();
    if (alreadyOpened == "false") {
      CustomNavigator.instance.pushNamed(RoutesName.otp, arguments: () async {
        CustomNavigator.instance.pop();

        /// repeat last request with fresh token

        await _repeatOnResponse(handler, requestOptions);
      });
    }
  }

  ///login,forget
  Future<void> unverifiedOnError(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final String? alreadyOpened = await isOtpScreenAlreadyOpened();
    if (alreadyOpened == "false") {
      CustomNavigator.instance.pushNamed(RoutesName.otp, arguments: () async {
        CustomNavigator.instance.pop();

        /// repeat last request with fresh token
        await _repeatOnError(handler, requestOptions);
      });
    }
  }

  Future<void> _handleDialogError(
      DioError error, ErrorInterceptorHandler handler) async {
    try {
      final Response<dynamic>? response = error.response;
      final Map<String, dynamic>? data =
          response?.data as Map<String, dynamic>?;
      final int outerCode = error.response!.statusCode!;
      log(error.response.toString());
      final int? innerCode = data?['code'] as int?;
      if (outerCode == 400) {
        switch (innerCode) {
          case 1062:
            unverifiedOnError(error.requestOptions, handler);
            break;
          case 1061:
          case 1082:
            unauthorizedDialog(error);
            break;
          case 1065:
            MyToast("don't have enough balanced");
            break;
          case 1442:
            MyToast('image exceeded the allowed size');
            break;
          // default:
          // if ((error.response?.data['errors'] as Map).containsKey('wallet_uuid')) {
          //   final RequestOptions requestOptions =
          //   (error.requestOptions..data.fields.add(const MapEntry('wallet_uuid', 'wallet_uuid')));
          //   _repeatOnError(handler, requestOptions);
          // }

        }
      } else if (outerCode == 401 && innerCode == 1041) {
        unauthorizedDialog(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _repeatOnError(
      ErrorInterceptorHandler handler, RequestOptions options) async {
    if (options.data is FormData) {
      options.data = createNewFormData(options.data as FormData);
    }
    try {
      await APIConnection.instance.dio.fetch(options).then(
        (Response<dynamic> response) {
          handler.resolve(response);
        },
        onError: (Object error) {
          handler.reject(_dioError(error, options));
        },
      );
    } catch (_) {}
  }

  Future<void> _repeatOnResponse(
      ResponseInterceptorHandler handler, RequestOptions options) async {
    if (options.data is FormData) {
      options.data = createNewFormData(options.data as FormData);
    }
    try {
      await APIConnection.instance.dio.fetch(options).then(
        (Response<dynamic> response) => handler.resolve(response),
        onError: (Object error) {
          handler.reject(_dioError(error, options));
        },
      );
    } catch (_) {}
  }

  DioError _dioError(Object error, RequestOptions options) {
    return error is DioError ? error : DioMixin.assureDioError(error, options);
  }

  Future<void> onResumeNetworkError(
      ErrorInterceptorHandler handler, DioError err) async {
    ///add api to queue
    repeating.add(() async {
      await _repeatOnError(handler, err.requestOptions);
    });
    log(err.requestOptions.path);
    log(err.requestOptions.data.toString());

    ///connection error
    if (!APIConnection.instance.networkError) {
      APIConnection.instance.networkError = true;
      await CustomNavigator.instance.pushNamed(RoutesName.networkError,
          arguments: () async {
        ///repeat all queue
        repeating.forEach((Future<void> Function() element) async {
          await element.call();
        });

        ///clear
        repeating.clear();
      });
    }
  }

  FormData createNewFormData(FormData data) {
    final FormData formData = FormData();
    formData.fields.addAll(data.fields);
    //formData.files.addAll(data.files);
    return formData;
  }

  Future<String?> isOtpScreenAlreadyOpened() =>
      sl<LocalStorageService>().readSecureKey("already_opened");
}
