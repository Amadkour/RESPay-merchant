import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/role_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/transaction_model.dart';

class SavingModel extends ParentModel {
  int? id;
  String? uuid;
  String? userUuid;
  double? total;
  bool? isActive;
  List<RoleModel>? rules;
  List<TransactionSavingModel>? transactions;

  SavingModel(
      {this.id,
      this.uuid,
      this.userUuid,
      this.total,
      this.isActive,
      this.rules,
      this.transactions});

  @override
  SavingModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final SavingModel savingModel = SavingModel(
      id: converter.convertToInt(key: 'id'),
      uuid: converter.convertToString(key: 'uuid'),
      userUuid: converter.convertToString(key: 'user_uuid'),
      total: converter.convertToDouble(key: 'total'),
      isActive: converter.convertToBool(key: 'is_active'),
    );

    //TODO:Parsing
    if (json['rules'] != null) {
      savingModel.rules = <RoleModel>[];
      (json['rules'] as List<dynamic>).forEach((dynamic v) {
        savingModel.rules!.add(RoleModel.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['transactions'] != null) {
      savingModel.transactions = <TransactionSavingModel>[];
      (json['transactions'] as List<dynamic>).forEach((dynamic v) {
        savingModel.transactions!
            .add(TransactionSavingModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return savingModel;
  }
}
