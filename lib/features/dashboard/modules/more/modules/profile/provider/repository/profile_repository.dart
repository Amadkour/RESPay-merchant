import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/API/profile_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';

class ProfileRepository {
  ProfileModel? data;

  final ProfileAPI _api;

  ProfileRepository(this._api);

  /// Show Profile
  Future<Either<Failure, ParentModel>> showProfileRepository() async {
    final Either<Failure, Response<Map<String, dynamic>>> res = await _api.showProfile();
    final ParentRepo<ProfileModel> parentRepo =
        ParentRepo<ProfileModel>(res, ProfileModel(),);
    return parentRepo.getRepoResponseAsFailureAndModel().fold((Failure l) {
      return Left<Failure, ProfileModel>(l);
    }, (ParentModel r) async {
      data = r as ProfileModel;
      return Right<Failure, ProfileModel>(r);
    });
  }

  /// Update Profile
  Future<Either<Failure, ParentModel>> updateProfileRepository(
      {required Map<String, dynamic> inputs}) async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await _api.updateProfile(inputs: inputs);
    final ParentRepo<ProfileModel> parentRepo =
        ParentRepo<ProfileModel>(res, ProfileModel());
    return parentRepo.getRepoResponseAsFailureAndModel().fold((Failure l) {
      return Left<Failure, ProfileModel>(l);
    }, (ParentModel r) {
      data = r as ProfileModel;
      return Right<Failure, ProfileModel>(r);
    });
  }
}
