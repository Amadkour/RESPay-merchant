import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';

class CelebritiesModel extends ParentModel{
  List<Celebrity>? celebrity;

  CelebritiesModel({this.celebrity});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return CelebritiesModel(
      celebrity: converter.convertToListOFModel(jsonData: json['celebrities'],modelInstance: Celebrity())
    );
  }
}
