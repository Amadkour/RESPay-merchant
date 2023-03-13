import 'package:bloc/bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/controller/transaction_type_dart_state.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/model/transaction_type_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/provider/repos/more_repository.dart';

class TransactionTypeCubit extends Cubit<TransactionTypeState> {
  TransactionTypeCubit() : super(TransactionTypeInitial()) {
    get();
  }
  List<TransactionTypeModel> types = <TransactionTypeModel>[];
  final TransactionTypeRepository _repository = sl<TransactionTypeRepository>();
  Future<void> get() async {
    types = await _repository.getMoreData();
  }
}
