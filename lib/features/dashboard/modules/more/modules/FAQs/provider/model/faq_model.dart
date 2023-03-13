import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class FaqModel extends ParentModel {
  FaqModel({
    String? message,
    required List<Faqs> feq,
  }) {
    _message = message;
    faqs = feq;
  }

  @override
  FaqModel fromJsonInstance(Map<String, dynamic> json) {
    _message = json['message'].toString();
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      (json['faqs'] as List<dynamic>).forEach((dynamic v) {
        faqs.add(Faqs.fromJson(v as Map<String, dynamic>));
      });
    } else {
      faqs = <Faqs>[];
    }
    return FaqModel(message: _message, feq: faqs);
  }

  String? _message;
  late List<Faqs> faqs;

  String? get message => _message;
}

class Faqs {
  Faqs({
    int? id,
    String? uuid,
    String? question,
    String? answer,
    required List<Faqs> subFaqs,
  }) {
    _id = id;
    _uuid = uuid;
    _question = question;
    _answer = answer;
    _subFaqs = subFaqs;
    isOpen = false;
  }

  Faqs.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    _id = converter.convertToInt(key: 'id');

    _uuid = converter.convertToString(key: 'uuid');

    _question = converter.convertToString(key: 'question');

    _answer = converter.convertToString(key: 'answer');

    if (json['sub_faqs'] != null) {
      _subFaqs = <Faqs>[];
      (json['sub_faqs'] as List<dynamic>).forEach((dynamic v) {
        _subFaqs.add(Faqs.fromJson(v as Map<String, dynamic>));
      });
    }

    isOpen = false;
  }

  int? _id;
  late bool isOpen;
  String? _uuid;
  String? _question;
  String? _answer;
  late List<Faqs> _subFaqs;

  int? get id => _id;

  String? get uuid => _uuid;

  String? get question => _question;

  String? get answer => _answer;

  List<Faqs> get subFaqs => _subFaqs;
}
