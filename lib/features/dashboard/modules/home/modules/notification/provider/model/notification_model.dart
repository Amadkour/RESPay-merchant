class NotificationModel {
  String? uuid;
  String? message;
  String? icon;
  DateTime? readAt;
  String? service;

  NotificationModel(
      {this.uuid, this.message, this.icon, this.readAt, this.service});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] as String?;
    message = json['message'] as String?;
    icon = json['icon'] as String?;
    readAt = json['read_at']!=null?DateTime.parse(json['read_at'] as String):null;
    service = json['service'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['message'] = message;
    data['icon'] = icon;
    data['read_at'] = readAt;
    data['service'] = service;
    return data;
  }
}
