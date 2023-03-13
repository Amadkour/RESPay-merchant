import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/base_transaction_api.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/item_transaction_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';

class TransactionHistoryRepo {
  final BaseTransactionApi _api;

  TransactionHistoryRepo(this._api);

  Future<Either<Failure, ParentModel>> get() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> map =
          await _api.getWallet();

      final ParentRepo<Wallet> parentRepo = ParentRepo<Wallet>(map, Wallet());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }

  Future<Either<Failure, ParentModel>> getTransactions(
      {HistoryFilterInput? filters}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> map =
          await _api.getTransactions(filters: filters);
      final ParentRepo<TransactionListModel> parentRepo =
          ParentRepo<TransactionListModel>(map, TransactionListModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }
}
