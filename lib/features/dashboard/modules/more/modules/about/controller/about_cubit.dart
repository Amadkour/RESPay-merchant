import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit(this._repository) : super(AboutInitial()) {
    init();
  }

  final TermPrivacyAboutRepository _repository;
  final List<TermPrivacyAboutModel> _aboutModels = <TermPrivacyAboutModel>[];

  List<TermPrivacyAboutModel> get aboutModels => _aboutModels;


  Future<void> init() async {
    emit(AboutLoading());

    try {
      (await _repository.getTermsPrivacyAboutRepository(endPoint: getAboutPath))
          .fold((Failure l) {
        emit(AboutFailure());
      }, (ParentModel response) {
        _aboutModels.add(response as TermPrivacyAboutModel);
      });
    } catch (e) {
      emit(AboutFailure());
    }finally{
      emit(AboutLoaded());
    }
  }
}
