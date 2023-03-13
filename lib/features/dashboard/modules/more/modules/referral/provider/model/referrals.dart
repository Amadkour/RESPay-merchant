import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class ReferralModel extends ParentModel {
  ReferralModel({
    String? refCode,
    List<Referrals>? referrals,
    Map<String,dynamic>? links
  }) {
    _refCode = refCode;
    _links=links;
    _referrals = referrals;
  }

  ReferralModel.fromJson(Map<String, dynamic> json) {
    _refCode = json['ref_code'] as String;
    if (json['referrals'] != null) {
      _referrals = <Referrals>[];
      (json['referrals'] as List<dynamic>).forEach((dynamic v) {
        _referrals?.add(Referrals.fromJson(v as Map<String,dynamic>));
      });
    }
    _links=json['links'] as Map<String,dynamic>;
  }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return ReferralModel(
        refCode: json['ref_code'] as String,
        links: json['links'] as Map<String,dynamic>,
        referrals: json['referrals'] != null
            ? (json['referrals'] as List<dynamic>)
                .map((dynamic e) => Referrals.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Referrals>[]);
  }

  String? _refCode;
  List<Referrals>? _referrals;

  String? get refCode => _refCode;

  Map<String,dynamic>? get links => _links;
  Map<String,dynamic>? _links;
  List<Referrals>? get referrals => _referrals;
}

class Referrals {
  Referrals({
    int? id,
    String? uuid,
    dynamic relatedTo,
    String? countryId,
    dynamic roleId,
    String? isVerified,
    String? isActive,
    String? phoneNumber,
    String? fullName,
    String? identityId,
    String? email,
    String? dob,
    dynamic locale,
    dynamic image,
    String? createdAt,
    dynamic pinCode,
    String? isTouchActive,
    String? isFaceActive,
    String? refUuid,
    dynamic refCode,
  }) {
    _id = id;
    _uuid = uuid;
    _relatedTo = relatedTo;
    _countryId = countryId;
    _roleId = roleId;
    _isVerified = isVerified;
    _isActive = isActive;
    _phoneNumber = phoneNumber;
    _fullName = fullName;
    _identityId = identityId;
    _email = email;
    _dob = dob;
    _locale = locale;
    _image = image;
    _createdAt = createdAt;
    _pinCode = pinCode;
    _isTouchActive = isTouchActive;
    _isFaceActive = isFaceActive;
    _refUuid = refUuid;
    _refCode = refCode;
  }

  Referrals.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    _id = converter.convertToInt(key: 'id');
    _uuid = converter.convertToString(key: 'uuid');
    _relatedTo = converter.convertToInt(key: 'related_to');
    _countryId = converter.convertToString(key: 'country_id');
    _roleId = converter.convertToInt(key: 'role_id');
    _isVerified = converter.convertToString(key: 'is_verified');
    _isActive = converter.convertToString(key: 'is_active');
    _phoneNumber = converter.convertToString(key: 'phone_number');
    _fullName = converter.convertToString(key: 'full_name');
    _identityId = converter.convertToString(key: 'identity_id');
    _email = converter.convertToString(key: 'email');
    _dob = converter.convertToString(key: 'dob');
    _locale = converter.convertToString(key: 'locale');
    _image = converter.convertToString(key: 'image');
    _createdAt = converter.convertToString(key: 'created_at');
    _pinCode = converter.convertToString(key: 'pin_code');
    _isTouchActive = converter.convertToString(key: 'is_touch_active');
    _isFaceActive = converter.convertToString(key: 'is_face_active');
    _refUuid = converter.convertToString(key: 'ref_uuid');
    _refCode = converter.convertToString(key: 'ref_code');
  }

  int? _id;
  String? _uuid;
  dynamic _relatedTo;
  String? _countryId;
  dynamic _roleId;
  String? _isVerified;
  String? _isActive;
  String? _phoneNumber;
  String? _fullName;
  String? _identityId;
  String? _email;
  String? _dob;
  dynamic _locale;
  dynamic _image;
  String? _createdAt;
  dynamic _pinCode;
  String? _isTouchActive;
  String? _isFaceActive;
  String? _refUuid;
  dynamic _refCode;

  int? get id => _id;

  String? get uuid => _uuid;

  dynamic get relatedTo => _relatedTo;

  String? get countryId => _countryId;

  dynamic get roleId => _roleId;

  String? get isVerified => _isVerified;

  String? get isActive => _isActive;

  String? get phoneNumber => _phoneNumber;

  String? get fullName => _fullName;

  String? get identityId => _identityId;

  String? get email => _email;

  String? get dob => _dob;

  dynamic get locale => _locale;

  dynamic get image => _image;

  String? get createdAt => _createdAt;

  dynamic get pinCode => _pinCode;

  String? get isTouchActive => _isTouchActive;

  String? get isFaceActive => _isFaceActive;

  String? get refUuid => _refUuid;

  dynamic get refCode => _refCode;
}
