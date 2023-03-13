import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

Country getCountry(int uuid) {
  return sl<List<Country>>()
      .firstWhere((Country element) => element.id == uuid);
}
