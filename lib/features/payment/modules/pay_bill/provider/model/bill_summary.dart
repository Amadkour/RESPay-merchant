import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class BillSummaryModel extends ParentModel{
  BillSummaryModel({
      Bill? bill,}){
    _bill = bill;
}

  BillSummaryModel.fromJson(Map<String,dynamic> json) {
    _bill = json['bill'] != null ? Bill.fromJson(json['bill'] as Map<String,dynamic>) : null;
  }
  Bill? _bill;

  Bill? get bill => _bill;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return BillSummaryModel(bill: json['bill'] != null ? Bill.fromJson(json['bill'] as Map<String,dynamic>) : null);

  }


}

class Bill {
  Bill({
      BillDetail? billDetail, 
      Total? total,}){
    _billDetail = billDetail;
    _total = total;
}

  Bill.fromJson(Map<String,dynamic> json) {
    _billDetail = json['bill_detail'] != null ? BillDetail.fromJson(json['bill_detail'] as Map<String,dynamic> ) : null;

    _total = json['total'] != null ? Total.fromJson(json['total'] as Map<String,dynamic>) : null;
  }
  BillDetail? _billDetail;
  Total? _total;

  BillDetail? get billDetail => _billDetail;
  Total? get total => _total;

}

class Total {
  Total({
      String? totalBill,
    String? bill,
    String? fee,}){
    _totalBill = totalBill;
    _bill = bill;
    _fee = fee;
}

  Total.fromJson(Map<String,dynamic> json) {
    final FromMap converter = FromMap(map: json);
    
    _totalBill =converter.convertToString(key:'total_bill') ;
    _bill =converter.convertToString(key:'bill') ;
    _fee =converter.convertToString(key:'fee') ;

  }
  String? _totalBill;
  String? _bill;
  String? _fee;

  String? get totalBill => _totalBill;
  String? get bill => _bill;
  String? get fee => _fee;

}

class BillDetail {
  BillDetail({
      String? company, 
      String? customerName, 
      String? customerId, 
      String? billingPeriod,}){
    _company = company;
    _customerName = customerName;
    _customerId = customerId;
    _billingPeriod = billingPeriod;
}

  BillDetail.fromJson(Map<String,dynamic> json) {
    final FromMap converter = FromMap(map: json);

    _company = converter.convertToString(key: 'company');
    _customerName = converter.convertToString(key: 'customer_name');
    _customerId = converter.convertToString(key: 'customer_id');
    _billingPeriod = converter.convertToString(key: 'billing_period');

  }
  String? _company;
  String? _customerName;
  String? _customerId;
  String? _billingPeriod;

  String? get company => _company;
  String? get customerName => _customerName;
  String? get customerId => _customerId;
  String? get billingPeriod => _billingPeriod;

}
