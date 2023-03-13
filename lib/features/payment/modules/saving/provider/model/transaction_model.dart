class TransactionSavingModel {
  String? walletUuid;
  String? referenceNumber;
  String? amount;
  String? type;
  String? name;
  DateTime? createdAt;

  TransactionSavingModel({this.walletUuid, this.referenceNumber, this.amount, this.type, this.name, this.createdAt});

  TransactionSavingModel.fromJson(Map<String, dynamic> json) {
    walletUuid = json['wallet_uuid'] as String;
    referenceNumber = json['reference_number'] as String;
    amount = json['amount'] as String;
    type = json['type'] as String;
    name = json['name'] as String;
    createdAt = DateTime.parse(json['created_at'] as String);
  }
}
