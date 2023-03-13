class BankList {
  BankList({
    int? id,
    String? uuid,
    String? name,
    int? countryId,
    bool? isDefault,
  }) {
    _id = id;
    _uuid = uuid;
    _name = name;
    _countryId = countryId;
    _isActive = true;
    _isDefault = isDefault;
  }

  BankList.fromJson(Map<String,dynamic> json) {
    _id = json['id'] as int;
    _uuid = json['uuid']as String;
    _name = json['name']as String;
    _countryId = json['country_id']as int;
    _isActive = json['is_active']as bool;
    _isDefault = json['is_default'] as bool;
  }

  int? _id;
  String? _uuid;
  String? _name;
  int? _countryId;
  bool? _isActive;
  bool? _isDefault;

  int get id => _id ?? 0;

  String get uuid => _uuid ?? '';

  String get name => _name ?? '';

  int get countryId => _countryId ?? 0;

  bool get isActive => _isActive ?? false;

  bool get isDefault => _isDefault ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['is_active'] = _isActive;
    map['is_default'] = _isDefault;
    return map;
  }
}
