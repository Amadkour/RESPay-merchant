import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/public_module/provider/dio_interceptor.dart';

enum BaseUrlModules {
  ecommerce,
  authentication,
  finance,
  wallet;

  String get name => urlFromEnum(this);
}

/// remove when new server is done
String urlFromEnum(BaseUrlModules? baseUrlModules) {
  if (!userOldServer) {
    return baseUrlModules.toString().split('.').last;
  } else {
    switch (baseUrlModules) {
      case BaseUrlModules.authentication:
        return "/authentication.eightyythree.com/api/authentication";
      case BaseUrlModules.ecommerce:
        return "/res-ecommerce.eightyythree.com/api/ecommerce";
      case BaseUrlModules.finance:
        return "/wallet.eightyythree.com/api/finance";
      case BaseUrlModules.wallet:
        return "/wallet.eightyythree.com/api/wallet";
      default:
        return "/authentication.eightyythree.com/api/authentication";
    }
  }
}

class APIConnection {
  bool showMessage = true;
  bool networkError = false;
  final Dio dio = Dio();

  APIConnection() {
    {
      // dio.options.baseUrl = "http://gfi.group/api";
      /// remove when new server is done
      dio.options.baseUrl = userOldServer ? "https:/" : "http://gfi.group/api";
      dio.options.followRedirects = false;

      dio.options.contentType = 'application/json';
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      dio.options.validateStatus = (int? statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 422) {
          // your http status code
          return false;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      };
      dio.options.setRequestContentTypeWhenNoPayload = true;
      dio.interceptors.add(DioInterceptor());
      dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
      ));
    }
  }

  APIConnection._singleTone() {
    {
      // dio.options.baseUrl = "http://gfi.group/api";
      /// remove when new server is done
      dio.options.baseUrl = userOldServer ? "https:/" : "http://gfi.group/api";
      dio.options.followRedirects = false;
      dio.options.contentType = 'application/json';
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      dio.options.setRequestContentTypeWhenNoPayload = true;
      dio.interceptors.add(DioInterceptor());
      dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
      ));
    }
  }

  static final APIConnection _instance = APIConnection._singleTone();

  static APIConnection get instance => _instance;
}
