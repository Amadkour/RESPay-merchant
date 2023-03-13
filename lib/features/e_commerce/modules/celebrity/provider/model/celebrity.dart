import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';

class Celebrity extends ParentModel {
  final String? id;
  final int? productCount;
  final String? name;
  final String? image;
  final CelebrityGender? gender;
  Celebrity({
    this.id,
    this.productCount,
    this.name,
    this.image,
    this.gender,
  });

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return Celebrity(
      id: converter.convertToString(key: "uuid"),
      productCount: converter.convertToInt(key: "product_count"),
      name: converter.convertToString(key: "full_name"),
      image: converter.convertToString(key: "image"),
      gender: CelebrityGender.men,
    );
  }
}
