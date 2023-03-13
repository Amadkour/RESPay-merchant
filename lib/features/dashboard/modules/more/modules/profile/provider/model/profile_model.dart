import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class ProfileModel extends ParentModel{
  String? phoneNumber;
  String? fullName;
  int? identityId;
  String? email;
  String? dob;
  String ?imageUrl;
  MultipartFile? image;
  String? message;

  ProfileModel(
      {this.phoneNumber,
      this.fullName,
        this.message,
        this.imageUrl,
      this.identityId,
      this.email,
      this.dob,
      this.image});

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = phoneNumber;
    data['full_name'] = fullName;
    data['identity_id'] = identityId;
    data['email'] = email;
    data['dob'] = dob;
    data['image']=image;
    return data;
  }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    if(json["user"]!=null){
      final FromMap converter = FromMap(map: json["user"] as Map<String,dynamic>);
      return ProfileModel(
          message: json['message']!=null?json['message'] as String:null,
          imageUrl : converter.convertToString(key: 'image', defaultValue: ''),
          phoneNumber : converter.convertToString(key: 'phone_number', defaultValue: ''),
          fullName : converter.convertToString(key: 'full_name', defaultValue: ''),
          email : converter.convertToString(key: 'email', defaultValue: ''),
          dob : converter.convertToString(key: 'dob', defaultValue: ''),
          identityId : converter.convertToInt(key: 'identity_id', defaultValue: 1)
      );
    }
    else{
      return ProfileModel(
        message: json['message']!=null?json['message'] as String:null,
      );
    }
  }
}
