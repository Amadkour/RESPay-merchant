import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/apis/more/endpoints.dart';

class ScheduleTimeApi {
  APIConnection apiConnection = APIConnection.instance;

  ScheduleTimeApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  ScheduleTimeApi._singleTone();

  static final ScheduleTimeApi _instance = ScheduleTimeApi._singleTone();

  static ScheduleTimeApi get instance => _instance;

  ///--------------get Days List
  Future<Either<Failure, Response<Map<String, dynamic>>>> getDaysList() async {
    //apiConnection.dio.options.baseUrl = 'https://authentication.eightyythree.com/api/authentication';

    apiConnection.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await apiConnection.dio.get(
        scheduleDaysPath,
      );

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      if (response != null) {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'days_api_line_90',
            errors: response.data!['errors'] as Map<String, dynamic>));
      } else {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure());
      }
    }
  }

  ///--------------get Times List
  Future<Either<Failure, Response<Map<String, dynamic>>>> getTimeList({String? day}) async {
    //apiConnection.dio.options.baseUrl = 'https://authentication.eightyythree.com/api/authentication';

    apiConnection.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await apiConnection.dio.get(scheduleTimePath, queryParameters: <String, dynamic>{"day": day});

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      if (response != null) {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'times_api_line_90',
            errors: response.data!['errors'] as Map<String, dynamic>));
      } else {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          errors: <String, String>{"": "connection error"},
        ));
      }
    }
  }

  ///--------------make A call

  Future<Either<Failure, Response<Map<String, dynamic>>>> makeCall({
    String? date,
    String? time,
  }) async {
    //apiConnection.dio.options.baseUrl = 'https://authentication.eightyythree.com/api/authentication';

    apiConnection.showMessage = true;
    Response<Map<String, dynamic>>? response;
    try {
      response = await apiConnection.dio
          .post(makeCallPath, data: FormData.fromMap(<String, dynamic>{'date': date, 'time': time}));

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      if (response != null) {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
            code: response.statusCode,
            resourceName: 'times_api_line_90',
            errors: response.data!['errors'] as Map<String, dynamic>));
      } else {
        return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          errors: <String, String>{"": "connection error"},
        ));
      }
    }
  }
}
