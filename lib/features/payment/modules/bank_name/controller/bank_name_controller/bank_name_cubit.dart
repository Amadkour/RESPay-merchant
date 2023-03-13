import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_name.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_names_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/repos/bank_name/bank_name_repo.dart';

part 'bank_name_state.dart';

class BankNameCubit extends Cubit<BankNameState> {
  BankNameRemoteRepo? bankNameRemoteRepo;
  List<BankName>? bankNames;
  String? errorMessage;

  BankNameCubit(this.bankNameRemoteRepo) : super(BankNameInitial());
  BankName? currentBankName;

  void setCurrentBankName(BankName value) {
    currentBankName = value;
    emit(BankNameValueChanged());
  }

  Future<void> getBankNames() async {
    try {
      if (bankNames != null) {
        if (bankNames!.isNotEmpty) {
          emit(BankNameLoadedState());
        } else {
          currentBankName = null;
          emit(BankNamesLoadingState());
          final Either<Failure, ParentModel> result = await bankNameRemoteRepo!.getAllBankNames();
          result.fold((Failure l) {
            errorMessage = l.message;
            emit(BankNameErrorState());
          }, (ParentModel r) {
            errorMessage = null;
            bankNames = (r as BankNamesModel).banks;
            currentBankName = bankNames!.first;
            emit(BankNameLoadedState());
          });
        }
      }
      else {
        currentBankName = null;
        emit(BankNamesLoadingState());
        final Either<Failure, ParentModel> result = await bankNameRemoteRepo!.getAllBankNames();
        result.fold((Failure l) {
          errorMessage = l.message;
          emit(BankNameErrorState());
        }, (ParentModel r) {
          errorMessage = null;
          bankNames = (r as BankNamesModel).banks;
          emit(BankNameLoadedState());
        });
      }
    } catch (e) {
      emit(BankNameErrorState());
    }
  }

  void reset() {
    currentBankName = null;
    emit(BankNameValueChanged());
  }
}
