import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/controller/otp_cubit.dart';

class ParentRepo<T extends ParentModel> {
  final Either<Failure, Response<Map<String, dynamic>>> response;
  late ParentModel modelInstance;
  late String? innerMapName;

  ParentRepo(this.response, this.modelInstance, {this.innerMapName});

  Either<Failure, ParentModel> getRepoResponseAsFailureAndModel() {
    return response.fold((Failure l) => Left<Failure, ParentModel>(l),
        (Response<Map<String, dynamic>> successResponse) {
      if (!<int>[200, 201].contains(successResponse.statusCode) ||
          !(successResponse.data!['success'] as bool)) {
        if (successResponse.statusCode == 404 &&
            successResponse.data!['success'] as bool) {
          return Right<Failure, ParentModel>(modelInstance.fromJsonInstance(
              innerMapName == null
                  ? successResponse.data!['data'] as Map<String, dynamic>
                  : ((successResponse.data!['data']
                          as Map<String, dynamic>)[innerMapName]
                      as Map<String, dynamic>)));
        } else {
          return Left<Failure, ParentModel>(ApiFailure(
              code: successResponse.statusCode,
              hint: (successResponse.data!['hint'] ??
                  successResponse.data!['errors'].toString()) as String,
              resourceName: 'banks_repository_line_40',
              errors: (successResponse.data!["errors"] ?? <dynamic>{})
                  as Map<String, dynamic>));
        }
      } else {
        if ((successResponse.data!['data'] as Map<String, dynamic>)
            .containsKey('confirmation_code')) {
          final String otp = (successResponse.data!['data']!
              as Map<String, dynamic>)['confirmation_code'] as String;
          sl<OtpCubit>().code = otp;
          MyToast(sl<OtpCubit>().code);
          return Left<Failure, ParentModel>(GeneralFailure(message: otp));
        } else {
          modelInstance = modelInstance.fromJsonInstance(innerMapName == null
              ? successResponse.data!['data'] as Map<String, dynamic>
              : ((successResponse.data!['data']
                      as Map<String, dynamic>)[innerMapName]
                  as Map<String, dynamic>));
          return Right<Failure, ParentModel>(modelInstance.fromJsonInstance(
              innerMapName == null
                  ? successResponse.data!['data'] as Map<String, dynamic>
                  : ((successResponse.data!['data']
                          as Map<String, dynamic>)[innerMapName]
                      as Map<String, dynamic>)));
        }
      }
    });
  }
}
