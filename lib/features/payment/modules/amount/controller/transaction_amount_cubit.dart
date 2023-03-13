import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/repos/currency_repo.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

part 'transaction_amount_state.dart';

class TransactionAmountCubit extends Cubit<TransactionAmountState> {
  TransactionAmountCubit({this.amount}) : super(TransactionAmountInitial()) {
    loadCurrencies();
  }

  final CurrencyRepository _currencyRepository = sl<CurrencyRepository>();

  List<Currency> currencies = <Currency>[];
  String? amount = '';
  String totalWallet = "0";
  Currency? currentCurrency;

  // void resetAmountField() {
  //   emit(TransactionAmountInitial());
  // }

  void reset() {
    currentCurrency = currencies.isNotEmpty ? currencies.first : null;
    amount = '';
    emit(TransactionAmountInitial());
    emit(CurrencyLoadedState());
  }

  Future<void> loadCurrencies() async {
    emit(CurrencyLoadingState());
    final Either<Failure, ParentModel> result = await _currencyRepository.getCurrencies();
    result.fold((Failure l) {
      emit(CurrencyLoadError(l));
    }, (ParentModel r) {
      currencies = (r as CurrencyListModel).currencies;
      currentCurrency = currencies.isNotEmpty ? currencies.first : null;

      emit(CurrencyLoadedState());
    });
  }

  void onAmountChange(String amount) {
    this.amount = amount;
    sl<GlobalCubit>().changeTextField();
  }

  void changeCurrency(Currency? currency) {
    currentCurrency = currency;

    emit(TransactionCurrencyChanged(currency!));
  }
}
