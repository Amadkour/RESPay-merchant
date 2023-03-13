class LimitsModel {
  String? limitPerTransaction;
  String? cashWithdrawLimit;
  String? cashbackBalance;

  LimitsModel(
      {this.limitPerTransaction, this.cashWithdrawLimit, this.cashbackBalance});

  LimitsModel.fromJson(Map<String, dynamic> json) {
    limitPerTransaction = json['limit_per_transaction'] as String;
    cashWithdrawLimit = json['cash_withdraw_limit'] as String;
    cashbackBalance = json['cashback_balance'] as String;
  }


}
