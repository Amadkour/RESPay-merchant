import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/api/base_category_api.dart';

class JsonCategoryApi extends BaseCategoryApi {
  @override
  Future<Map<String, dynamic>> get() async {
    final String json = await rootBundle.loadString('assets/jsons/category.json');

    return jsonDecode(json) as Map<String, dynamic>;
  }
}
