import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/base_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';

class RemoteBudgetApi extends BaseBudgetApi {
  late Dio _dio;

  RemoteBudgetApi({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCategories(
      {String? period}) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.get(getBudgetApi, queryParameters: <String, dynamic>{
        "filter": period,
      });

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> create(
      CreateBudgetCategoryInput input) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.post(createBudgetCategoryApi, data: input.toMap());

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Option<Failure>> delete(String uuid) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.post(deleteBudgetCategoryApi,
              data: FormData.fromMap(<String, dynamic>{
                "uuid": uuid,
              }));

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return none();
      } else {
        return some(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return some(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return some(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> update(
      CreateBudgetCategoryInput input) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.post(
        updateBudgetCategoryApi,
        data: input.toMap(),
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Option<Failure>> changeStatus(String uuid) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.post(toggleCategoryApi,
              data: FormData.fromMap(<String, dynamic>{
                "uuid": uuid,
              }));

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return none();
      } else {
        return some(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return some(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return some(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }
}
