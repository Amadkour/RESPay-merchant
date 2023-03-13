import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/terms_privacy_about_api.dart';

class TermPrivacyAboutRepository {
  late TermsPrivacyAboutAPI _termsPrivacyAboutAPI;

  TermPrivacyAboutRepository({TermsPrivacyAboutAPI? termsPrivacyAboutAPI}) {
    _termsPrivacyAboutAPI =
        termsPrivacyAboutAPI ?? TermsPrivacyAboutAPI.instance;
  }

  TermPrivacyAboutRepository._singleTone() {
    _termsPrivacyAboutAPI = TermsPrivacyAboutAPI.instance;
  }

  static final TermPrivacyAboutRepository _instance =
      TermPrivacyAboutRepository._singleTone();

  static TermPrivacyAboutRepository get instance => _instance;

  TermPrivacyAboutModel data = TermPrivacyAboutModel();

  /// Get Saving, transactions and roles
  Future<Either<Failure, ParentModel>> getTermsPrivacyAboutRepository(
      {required String endPoint}) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _termsPrivacyAboutAPI.getTermsPrivacyAbout(endPoint: endPoint);

    ///--------
    final ParentRepo<TermPrivacyAboutModel> parentRepo =
        ParentRepo<TermPrivacyAboutModel>(apiResponse, TermPrivacyAboutModel());
    parentRepo.getRepoResponseAsFailureAndModel();
    data = parentRepo.modelInstance as TermPrivacyAboutModel;
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
