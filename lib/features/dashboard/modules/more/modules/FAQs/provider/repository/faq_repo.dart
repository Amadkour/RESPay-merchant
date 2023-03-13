import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/api/faq_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/model/faq_model.dart';

class FAQsRepo {
  late FAQApi _faqApi;

  FAQsRepo({FAQApi? faqApi}) {
    _faqApi = faqApi ?? FAQApi.instance;
  }

  FAQsRepo._singleTone() {
    _faqApi = FAQApi.instance;
  }

  static final FAQsRepo _instance = FAQsRepo._singleTone();

  static FAQsRepo get instance => _instance;

  /// Get Saving, transactions and roles
  Future<Either<Failure, ParentModel>> getFAQs() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _faqApi.getFAQs();

    ///--------
    final ParentRepo<FaqModel> parentRepo =
        ParentRepo<FaqModel>(apiResponse, FaqModel(feq: <Faqs>[]));
    parentRepo.getRepoResponseAsFailureAndModel();
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
