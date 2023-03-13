
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/api/referral/remote_referral_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/model/referrals.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/model/user_model.dart';

class RemoteReferralApiRepo{
  final RemoteReferralApi _api;
  RemoteReferralApiRepo(this._api);

  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final Either<Failure, List<dynamic>> options =  await _api.getUsers();
      return options.fold((Failure l) {
        return left(
          NetworkFailure(
              // message: l.toString()
          ),
        );
      }, (List<dynamic> r) {
        if(r.isEmpty){
          return left(ApiFailure(

              code: 404,
              errors: <String,String>{"error":"error"},
              resourceName: "Referral repo line 18"));
        }
        else{
          return right(r.map((dynamic e) => UserModel().fromJsonInstance(e as Map<String,dynamic>)).toList());
        }
      });
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    }
    on ServerException catch (e) {
      return left(ApiFailure(

          code: e.statusCode,
          errors: e.errors,
          resourceName: "Referral repo line 18"));
    }
  }

///-----------------Referral Repo
  Future<Either<Failure, ParentModel>> getReferralUR() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await RemoteReferralApi.instance.copyURL();

    final ParentRepo<ReferralModel> parentRepo = ParentRepo<ReferralModel>(apiResponse, ReferralModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
