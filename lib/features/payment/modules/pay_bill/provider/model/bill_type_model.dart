class BillTypeModel {
  BillTypeModel({
      int? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  BillTypeModel.fromJson(Map<String,dynamic> json) {
    _id = json['id'] as int;
    _name = json['name']as String;
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}
