import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

class GetItInstance {
  void loadLanguage(String value) {
    sl<GlobalCubit>().loadLanguage(value);
  }
}
