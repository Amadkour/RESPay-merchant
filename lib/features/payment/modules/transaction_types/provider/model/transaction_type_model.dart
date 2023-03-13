// ignore: must_be_immutable

class TransactionTypeModel {
  TransactionTypeModel({
    required String icon,
    required String name,
    required String navigateTo,
  }) {
    _icon = icon;
    _name = name;
    _navigateTo = navigateTo;
  }

  TransactionTypeModel.fromJson(Map<String, dynamic> json) {
    _icon = json['icon'].toString();
    _name = json['name'].toString();
    _navigateTo = json['navigate_to'].toString();
  }
  late String _icon;
  late String _name;
  late String? _navigateTo;

  String get icon => _icon;
  String get name => _name;
  String get navigateTo => _navigateTo!;
}
