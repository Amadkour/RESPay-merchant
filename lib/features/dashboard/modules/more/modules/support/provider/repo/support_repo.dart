import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/api/support_remote_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/model/support_request_model.dart';

class SupportRepository {
  final SupportRemoteApi _api;

  SupportRepository(this._api);

  Future<Either<Failure, ParentModel>> sendSupportRequest(
      {required Map<String, dynamic> input}) async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
    await _api.sendSupportRequest(input: input);
    final ParentRepo<SupportResponseModel> parentRepo = ParentRepo<SupportResponseModel>(res, SupportResponseModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
