import 'package:dartz/dartz.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/api/base_category_api.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/model/category_model.dart';

class CategoryRepo {
  final BaseCategoryApi _api;

  CategoryRepo(this._api);

  Future<Either<Failure, List<CategoryModel>>> get() async {
    final Map<String, dynamic> data = await _api.get();
    final List<Map<String, dynamic>> categories = (data['categories'] as List<dynamic>).cast<Map<String, dynamic>>();
    return right(List<CategoryModel>.from(categories.map((Map<String, dynamic> map) => CategoryModel.fromMap(map))));
  }
}
