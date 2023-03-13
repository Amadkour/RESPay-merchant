import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/repository/language_repository.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
      : super(LanguageInitial()) {
    init();
  }


  String _radioGroupValue = 'en';

  String? get radioGroupValue => _radioGroupValue;
  List<LanguageModel> _languageModels = <LanguageModel>[];

  List<LanguageModel> get languageModels => _languageModels;

  Future<void> init() async {
    emit(LanguageLoading());
    print('language  = ${sl<LocalStorageService>().readString('lang')}');
    _radioGroupValue = sl<LocalStorageService>().readString('lang');
    print('/////////////////// language $_radioGroupValue loaded');

    print("========================$_radioGroupValue");
    (await sl.get<LanguageRepository>().getLanguagesRepository()).fold((Failure l) => null,
            (List<LanguageModel> response) {
          _languageModels = response;
        });
    emit(LanguageLoaded());
  }

  void toggleLanguage(String? value) {
    _radioGroupValue = value!;
    emit(LanguageChangeRadioValue());
  }

  Future<String> onTapButton() async {
    emit(LanguageChangeLanguageLoading());
    String message = '';
print("--------------------$_radioGroupValue");
    /// Change language key format from en_US to en and ar_AE to ar to send it to api
    try {
      return (await sl.get<LanguageRepository>().setLanguageRepository(apiLang: _radioGroupValue))
          .fold((Failure l) {
        return tr('something_went_wrong');
      }, (Map<String, dynamic> r) async {
        /// Load new language
        await sl<GlobalCubit>().loadLanguage(_radioGroupValue);
        emit(LanguageChangeLanguageLoaded());

        /// load new language
        return tr('language_changed_successfully');
      });
    } catch (e) {
      message = tr('something_went_wrong');
      emit(LanguageFailure());
    }

    return message;
  }
}
