import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/country_type.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/country_type_repository.dart';
part 'country_type_state.dart';

class CountryTypeCubit extends Cubit<CountryTypeState> {
  CountryTypeCubit() : super(CountryTypeInitial()) {
    init();
  }


  /// -------------------------------- Initialization -------------------------------- ///
  List<CountryType> countryTypes = <CountryType>[];
  CountryType? selectedCountry;


  /// Call when opening the page
  Future<void> init() async {
    countryTypes =
        await CountryTypeRepository.instance.getCountryListRepository();
    selectedCountry = countryTypes[0];
    emit(CountryTypeLoaded());
  }
  /// Change Country in the phone number TextField
  void changeSelectedCountry(int index) {
    selectedCountry = countryTypes[index];

    emit(CountryTypeChangeSelectedCountry());
  }
}
