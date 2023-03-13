import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/base_celebrity_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrities_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/single_celebrity_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';

class CelebrityRepo {
  final BaseCelebrityApi _api;

  CelebrityRepo(this._api);

  Future<Either<Failure, ParentModel>> getAllCelebrities() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse = await _api.getAllCelebrities();

    ///--------
    final ParentRepo<CelebritiesModel> parentRepo =
    ParentRepo<CelebritiesModel>(apiResponse, CelebritiesModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getSingleCelebrityData({required String celebrityUuid}) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse = await _api.getSingleCelebrity(celebrityUuid: celebrityUuid);

    ///--------
    final ParentRepo<SingleCelebrityData> parentRepo =
    ParentRepo<SingleCelebrityData>(apiResponse, SingleCelebrityData());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, List<Story>>> getVideos() async {
    final Map<String, dynamic> map = await _api.getVideos();

    final List<Map<String, dynamic>> list = (map['videosList'] as List<dynamic>).cast<Map<String, dynamic>>();

    return right(List<Story>.from(list.map((Map<String, dynamic> e) => Story.fromJson(e))).toList());
  }
}
