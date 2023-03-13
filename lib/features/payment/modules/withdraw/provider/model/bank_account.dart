import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';


class BankAccount extends ParentModel {
  BankAccount({
    List<BankAccounts>? bankAccounts,
  }) {
    _bankAccounts = bankAccounts;
  }

  @override
  ParentModel fromJsonInstance(Map<String,dynamic> json) {
    if (json['bank_accounts'] != null) {
      _bankAccounts = <BankAccounts>[];
      (json['bank_accounts']as List<dynamic>).forEach((dynamic v) {
        _bankAccounts?.add(BankAccounts.fromJson(v as Map<String,dynamic>));
      });
    }
    return BankAccount(bankAccounts: _bankAccounts);
  }

  List<BankAccounts>? _bankAccounts;

  List<BankAccounts>? get bankAccounts => _bankAccounts;

}

class BankAccounts {

  BankAccounts(
      this._id, this._uuid, this._iban, this._accountNumber, this._bankName);

  BankAccounts.fromJson(Map<String,dynamic> json) {
    final FromMap fromMap=FromMap(map: json);
    _id = fromMap.convertToString(key: 'id');
    _uuid = fromMap.convertToString(key: 'uuid');
    _iban = fromMap.convertToString(key: 'iban');
    _accountNumber = fromMap.convertToString(key: 'account_number');
    _bankName = fromMap.convertToString(key: 'bank_name');
  }

  String? _id;
  String? _uuid;
  String? _iban;
  String? _accountNumber;
  String? _bankName;

  String? get id => _id;

  String? get uuid => _uuid;


  String? get iban => _iban;

  String? get accountNumber => _accountNumber;

  String? get bankName => _bankName;
}
