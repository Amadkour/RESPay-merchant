import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class TransactionModel with EquatableMixin {
  TransactionModel({
    String? icon,
    String? operationName,
    DateTime? date,
    String? amount,
    String? reference,
    String? slug,
    String? walletUuid,
    String? method,
  }) {
    _icon = icon;
    _operationName = operationName;
    _date = date;
    _amount = amount;
    _slug = slug;
    _reference = reference;
    _walletUuid = walletUuid;
    _method = method;
  }

  TransactionModel.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);

    _icon = converter.convertToString(key: 'icon');
    _operationName = converter.convertToString(key: 'type');
    _date = converter.convertToDateTime(key: 'created_at');
    _amount = converter.convertToString(key: 'amount');
    _reference = converter.convertToString(key: 'reference_number');
    _walletUuid = converter.convertToString(key: 'wallet_uuid');
    _method = converter.convertToString(key: 'method');
    _slug = converter.convertToString(key: 'slug');
  }

  String? _icon;
  String? _operationName;
  DateTime? _date;
  String? _amount;
  String? _slug;
  String? _walletUuid;
  String? _reference;
  String? _method;

  String? get icon => _icon;

  String get operationName => _operationName!;

  DateTime get date => _date!;

  String get amount => _amount!;

  String get slug => _slug!;

  String get walletUuid => _walletUuid!;

  String get reference => _reference!;

  String get method => _method!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['icon'] = _icon;
    map['operation_name'] = _operationName;
    map['date'] = _date;
    map['amount'] = _amount;
    return map;
  }

  @override
  List<Object?> get props => <Object?>[
        icon,
        operationName,
        date,
        amount,
        reference,
        walletUuid,
      ];
}
