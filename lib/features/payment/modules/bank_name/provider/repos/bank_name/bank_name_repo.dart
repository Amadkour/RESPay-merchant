import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/bank_name/bank_name_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_names_model.dart';

class BankNameRemoteRepo {
  final BankNameRemoteApi _api;
  BankNameRemoteRepo(this._api);

  Future<Either<Failure, ParentModel>> getAllBankNames() async {

    try{
      final Either<Failure, Response<Map<String,dynamic>>> res = await _api.getAllBankNames();
      final ParentRepo<BankNamesModel> parentRepo =
      ParentRepo<BankNamesModel>(res, BankNamesModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch(e){
      return Left<Failure, ParentModel>(ApiFailure(
          errors: <String,String>{"":"Error when trying to get bank names"},

      )
      );
    }
  }
}
