import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/item_transaction_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/repos/transaction_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/model/transaction_type_model.dart';

part 'transaction_history_state.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  TransactionHistoryCubit({TransactionHistoryRepo? repo})
      : super(TransactionHistoryInitial()) {
    _repo = repo ?? sl<TransactionHistoryRepo>();
  }

  late TransactionHistoryRepo _repo;

  List<TransactionModel> transactions = <TransactionModel>[];

  Wallet? wallet;
  String? filterCategory;
  String? period;
  String query = '';
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();

  TransactionListModel? _historyMap;

  Map<String, List<TransactionModel>> get groupedData {
    if (query.isEmpty) {
      return _historyMap?.transactions ?? <String, List<TransactionModel>>{};
    } else {
      final Map<String, List<TransactionModel>> items = {};
      (_historyMap?.transactions ?? <String, List<TransactionModel>>{})
          .forEach((String key, List<TransactionModel> value) {
        if (value.any((TransactionModel element) =>
            element.amount.toLowerCase().startsWith(query.toLowerCase()) ||
            DateFormat('dd MMMM', 'en_US')
                .format(element.date)
                .startsWith(query.toLowerCase()) ||
            element.operationName
                .toLowerCase()
                .startsWith(query.toLowerCase()))) {
          items[key] = value
              .where((TransactionModel element) =>
                  element.amount
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  DateFormat('dd MMMM', 'en_US')
                      .format(element.date)
                      .startsWith(query.toLowerCase()) ||
                  element.operationName
                      .toLowerCase()
                      .startsWith(query.toLowerCase()))
              .toList();
        }
      });
      return items;
    }
  }

  Map<String, String> get periodTypes =>
      _historyMap?.periodTypes ?? <String, String>{};

  List<String> get transactionTypes => _historyMap?.types ?? <String>[];

  Future<void> init() async {
    if (await sl<LocalStorageService>().containSecureKey(userToken)) {
      try {
        await getWallet();
        await getAllTransactions();
      } catch (e) {
        emit(TransactionHistoryError(GeneralFailure(
          errors: <String, String>{'': e.toString()},
        )));
      }
    }
  }

  //!tested
  Future<void> getWallet() async {
    emit(WalletLoading());
    final Either<Failure, ParentModel> result = await _repo.get();
    return result.fold((Failure l) {
      emit(WalletFailure(l));
    }, (ParentModel r) {
      wallet = r as Wallet;
      transactions = r.transactions;
      emit(WalletLoaded());
    });
  }

  Future<void> loadTransactions() async {
    if (filterCategory != null) {
      filterByCategory();
    } else {
      getAllTransactions();
    }
  }

  //! tested
  Future<void> getAllTransactions() async {
    try {
      emit(TransactionHistoryLoading());
      final Either<Failure, ParentModel> result = await _repo.getTransactions();
      _onLoadTransactionsCallback(result);
    } catch (e) {
      emit(TransactionHistoryError(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      )));
    }
  }

//!tested
  Future<void> filterByCategory() async {
    try {
      emit(TransactionHistoryLoading());
      final Either<Failure, ParentModel> result = await _repo.getTransactions(
          filters: HistoryCategoryFilterInput(filterCategory!));
      _onLoadTransactionsCallback(result);
    } catch (e) {
      emit(TransactionHistoryError(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      )));
    }
  }

//!tested
  Future<void> filterByPeriod() async {
    try {
      emit(TransactionHistoryLoading());
      final Either<Failure, ParentModel> result = await _repo.getTransactions(
          filters: HistoryPeriodFilterInput(
        from: from.text,
        to: to.text,
        period: period,
      ));
      _onLoadTransactionsCallback(result);
    } catch (e) {
      emit(TransactionHistoryError(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      )));
    }
  }

  void _onLoadTransactionsCallback(Either<Failure, ParentModel> result) {
    return result.fold((Failure l) {
      emit(TransactionHistoryError(l));
    }, (ParentModel r) {
      _historyMap = r as TransactionListModel;
      emit(TransactionHistoryLoaded());
    });
  }

  Future<void> searchInTransactions({required String query}) async {
    this.query = query;
    emit(TransactionHistoryLoaded());
    // final Either<Failure, ParentModel> result = await _repo.getTransactions(filters: HistorySearchInput(query));
    // _onLoadTransactionsCallback(result);
  }

//!tested
  void setPeriod(String? period) {
    this.period = period;
    emit(HistoryPeriodChanged(period));
  }

//!tested
  void setCategory(String category) {
    filterCategory = category;
  }

  void resetValues() {
    filterCategory = null;
    period = null;
    from.text = '';
    to.text = '';
    query = '';
  }

  @override
  Future<void> close() {
    from.dispose();
    to.dispose();
    return super.close();
  }
}
