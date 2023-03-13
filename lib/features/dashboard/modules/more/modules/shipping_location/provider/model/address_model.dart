import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class AddressModel extends ParentModel{
  String? uuid;
  String? streetName;
  String? state;
  String? apartment;
  String? zipCode;
  String? countryUUID;
  String? city;
  bool? status;
  bool? isDefault;

  AddressModel(
      {this.uuid,
        this.streetName,
        this.state,
        this.apartment,
        this.zipCode,
        this.countryUUID,
        this.city,
        this.status,
        this.isDefault});
  @override
  AddressModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    final AddressModel addressModel = AddressModel(
      uuid: converter.convertToString(key: 'uuid'),
      streetName: converter.convertToString(key: 'street_name'),
      countryUUID: converter.convertToString(key: 'country'),
      city: converter.convertToString(key: 'city'),
      state: converter.convertToString(key: 'state'),
      status: converter.convertToBool(key: 'status'),
      isDefault: converter.convertToBool(key: 'is_default'),
      apartment: converter.convertToString(key: 'apartment'),
      zipCode: converter.convertToString(key: 'zip_code'),
    );
    return addressModel;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['street_name'] = streetName;
    data['state'] = state;
    data['apartment'] = apartment;
    data['zip_code'] = zipCode;
    data['country'] = countryUUID;
    data['city'] = city;
    data['status'] = status;
    data['is_default'] = isDefault;
    return data;
  }
}
