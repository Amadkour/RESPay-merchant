import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

class TransactionListModel extends ParentModel with EquatableMixin {
  Map<String, List<TransactionModel>> transactions;
  Map<String, String> periodTypes;
  List<String> types;
  TransactionListModel({
    this.transactions = const <String, List<TransactionModel>>{},
    this.periodTypes = const <String, String>{},
    this.types = const <String>[],
  });
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final dynamic map = json['transactions'];
    Map<String, dynamic> transactions = <String, dynamic>{};
    if (map is Map) {
      transactions = map as Map<String, dynamic>;
    }

    final Map<String, List<TransactionModel>> listOfTransactions = <String, List<TransactionModel>>{};

    transactions.forEach((String key, dynamic value) {
      final List<TransactionModel> castedValues = List<TransactionModel>.from(
          (value as List<dynamic>).map((dynamic e) => TransactionModel.fromJson(e as Map<String, dynamic>)));

      listOfTransactions.addAll(<String, List<TransactionModel>>{key: castedValues});
    });

    return TransactionListModel(
      transactions: listOfTransactions,
      periodTypes: Map<String, String>.from(
        json['period_types'] as Map<String, dynamic>,
      ),
      types: (json['transaction_types'] as Map<String, dynamic>).keys.cast<String>().toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[transactions, periodTypes, types];
}
