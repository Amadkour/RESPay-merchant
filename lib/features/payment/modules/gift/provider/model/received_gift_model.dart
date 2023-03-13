

class TodayGifts {
  List<ReceivedGiftModel>? receivedGiftModels;

  TodayGifts({this.receivedGiftModels});

  TodayGifts.fromMap(Map<String, dynamic> json) {
    receivedGiftModels=<ReceivedGiftModel>[];
    (json['recived_gift'] as List<dynamic>).forEach((dynamic element) {
      receivedGiftModels!
          .add(ReceivedGiftModel.fromMap(element as Map<String, dynamic>));
    });
  }
}

class ReceivedGiftModel {
  String? gift;
  DateTime? createdAt;

  ReceivedGiftModel({this.gift, this.createdAt});

  ReceivedGiftModel.fromMap(Map<String, dynamic> json) {
    gift = json['gift'].toString();
    createdAt =DateTime.parse(json['created_at'].toString());
  }
}
