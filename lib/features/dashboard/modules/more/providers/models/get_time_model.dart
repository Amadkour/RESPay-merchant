import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class GetTimeModel extends ParentModel {
  GetTimeModel({
    String? message,
    List<Times>? times,
  }) {
    _message = message;
    _times = times;
  }

  // GetTimeModel.fromJson(Map<String,dynamic> json) {
  //
  //   _message = json['message'];
  //   if (json['times'] != null) {
  //     _times = [];
  //     json['times'].forEach((v) {
  //       _times?.add(Times.fromJson(v));
  //     });
  //   }
  // }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return GetTimeModel(
        message: json['message'] as String,
        times: json['times'] != null
            ? (json['times'] as List<dynamic>)
                .map((dynamic e) => Times.fromJson(e as Map<String, dynamic>)).toList()
            : <Times>[]
    ) ;
  }

  String? _message;
  List<Times>? _times;

  String? get message => _message;

  List<Times>? get times => _times;
}

class Times {
  Times({
    String? time,
    bool? isBooked,
  }) {
    _time = time;
    isBooked = isBooked;
  }

  Times.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);

    _time = converter.convertToString(key: 'time');
    // _time = converter.convertToString(key: 'time')!.split(':').first);
    isBooked = converter.convertToBool(key: 'is_booked');
  }

  String? _time;
  bool? isBooked;

  String? get time => _time;

}
