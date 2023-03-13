import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

class SingleCelebrityData extends ParentModel{
  Celebrity? celebrity;
  int? productCount;
  List<ProductModel>? products;
  List<Banners>?banners;

  SingleCelebrityData({this.celebrity, this.productCount, this.products,this.banners});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    if (json['banners'] != null) {
      banners = <Banners>[];
      (json['banners'] as List<dynamic>).forEach((dynamic v) {
        banners?.add(Banners.fromJson(v as Map<String, dynamic>));
      });
    }
    return SingleCelebrityData(
      celebrity: Celebrity().fromJsonInstance(json['celebrity'] as Map<String,dynamic>) as Celebrity,
      productCount: converter.convertToInt(key: "product_count"),
      products: converter.convertToListOFModel(modelInstance: ProductModel(),jsonData: json['products']),
      banners: json['banners'] == null?<Banners>[]:(json['banners'] as List<dynamic>).map((dynamic e) => Banners.fromJson(e as Map<String, dynamic>)).toList()
    );
  }
}
