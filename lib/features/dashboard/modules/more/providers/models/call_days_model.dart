import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class CallDaysModel extends ParentModel {
  CallDaysModel({
    String? message,
    bool? isSelected,
    List<DateTime>? days,
  }) {
    _message = message;
    _days = days;
    _isSelected = isSelected;
  }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return CallDaysModel(
        message: json['message'] as String,
        isSelected: false,
        days:
            (json['days'] != null ? (json['days'] as List<dynamic>) : <dynamic>[]).map((dynamic e) {
          final List<String> day = (e as String).split('-');
          return DateTime.parse(day.reversed.join('-'));
        }).toList());
  }

  String? _message;
  bool? _isSelected;
  List<DateTime>? _days;

  String? get message => _message;

  bool? get isSelected => _isSelected;

  List<DateTime>? get days => _days;
}
