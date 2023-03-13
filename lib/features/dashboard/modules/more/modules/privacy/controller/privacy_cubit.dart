import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

part 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit(this._repository) : super(PrivacyInitial()) {
    init();
  }
  final TermPrivacyAboutRepository _repository;

  final List<TermPrivacyAboutModel> _privacyModels = <TermPrivacyAboutModel>[];

  List<TermPrivacyAboutModel> get privacyModels => _privacyModels;

  Future<void> init() async {
    emit(PrivacyLoading());

    try {
      (await _repository
              .getTermsPrivacyAboutRepository(endPoint: getPrivacyPath))
          .fold((Failure l) {
        emit(PrivacyChangeFailure());
      }, (ParentModel response) {
        _privacyModels.add(response as TermPrivacyAboutModel);
      });
    } catch (e) {
      emit(PrivacyChangeFailure());
    }
    emit(PrivacyLoaded());
  }

  void changePrivacyExpanded(int index) {
    _privacyModels[index].isExpanded = !_privacyModels[index].isExpanded!;
    emit(PrivacyChangeExpanded());
  }
}
