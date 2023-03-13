import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

Currency getCurrency(int id) {
  return sl<List<Currency>>()
      .firstWhere((Currency element) => element.id == id);
}
