class TransactionGlobalModel {
  int? id;
  String? image;
  String? title;
  String? date;
  String? transaction;

  TransactionGlobalModel({this.id, this.image, this.title,this.transaction,this.date});

  TransactionGlobalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    image = json['image'] as String;
    title = json['title'] as String;
    date = json['date'] as String;
    transaction = json['transaction'] as String;
  }
}
