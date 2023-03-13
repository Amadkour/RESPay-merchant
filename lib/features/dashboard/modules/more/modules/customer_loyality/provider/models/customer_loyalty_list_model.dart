import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';

class CustomerLoyaltyListModel extends ParentModel {
  final List<CustomerLoyaltyModel> list;

  CustomerLoyaltyListModel({
    this.list = const <CustomerLoyaltyModel>[],
  });
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<CustomerLoyaltyModel> list = (json['shops'] as List<dynamic>)
        .map((dynamic e) => CustomerLoyaltyModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return CustomerLoyaltyListModel(list: list);
  }
}
