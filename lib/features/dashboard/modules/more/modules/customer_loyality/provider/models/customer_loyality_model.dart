class CustomerLoyaltyModel {
  CustomerLoyaltyModel({
    this.title,
    this.description,
    this.icon,
    this.rate,
    this.uuid,
  });

  CustomerLoyaltyModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'] as String;
    title = json['name'] as String;
    rate = json['stars'] as int;
    uuid = json['uuid'] as String?;
  }

  String? uuid;
  String? icon;
  String? title;
  int? rate;
  String? description;
}
