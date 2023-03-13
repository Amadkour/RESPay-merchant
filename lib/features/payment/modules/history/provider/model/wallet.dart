import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

class Wallet extends ParentModel with EquatableMixin {
  final int? id;
  final String? uuid;
  final double? total;
  final bool? isActive;
  final bool? isNormal;
  final bool? isSaving;
  final List<TransactionModel> transactions;
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['wallet'] as Map<String, dynamic>;

    return Wallet(
      id: data['id'] as int,
      uuid: data['uuid'] as String,
      total: (data['total'] as num?)?.toDouble() ?? 0,
      isActive: data['is_active'] as bool,
      isNormal: data['is_normal'] as bool,
      isSaving: data['is_saving'] as bool,
      transactions: List<TransactionModel>.from(
        (data['transactions'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map<TransactionModel>(
              (Map<String, dynamic> x) => TransactionModel.fromJson(x),
            ),
      ),
    );
  }

  Wallet({
    this.id,
    this.uuid,
    this.total,
    this.isActive,
    this.isNormal,
    this.isSaving,
    this.transactions = const <TransactionModel>[],
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        uuid,
        total,
        isActive,
        isNormal,
        isSaving,
        transactions,
      ];
}
