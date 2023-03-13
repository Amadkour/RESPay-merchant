import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/apis/more/schedual_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/call_days_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/get_time_model.dart';

class ScheduleRepo {
  Future<Either<Failure, ParentModel>> getDaysList() async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await ScheduleTimeApi.instance.getDaysList();
    final ParentRepo<CallDaysModel> parentRepo = ParentRepo<CallDaysModel>(res, CallDaysModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getTimesList(String day) async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await ScheduleTimeApi.instance.getTimeList(day: day);

    ///--------
    final ParentRepo<GetTimeModel> parentRepo = ParentRepo<GetTimeModel>(res, GetTimeModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, Map<String, dynamic>>> makeCall({
    String? date,
    String? time,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await ScheduleTimeApi.instance.makeCall(date: date, time: time);

      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'makeCall_repository_line_55',
              errors: (response.data!['errors'] ?? <dynamic>{}) as Map<String, dynamic>));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'makeCall_repository_line_65',
      ));
    }
  }
}
