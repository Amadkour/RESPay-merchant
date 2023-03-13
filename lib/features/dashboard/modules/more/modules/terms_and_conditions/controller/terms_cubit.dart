import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit(this._repository) : super(TermsInitial()) {
    init();
  }

  final TermPrivacyAboutRepository _repository;


  final List<TermPrivacyAboutModel> _terms = <TermPrivacyAboutModel>[];

  List<TermPrivacyAboutModel> get terms => _terms;

  Future<void> init() async {
    emit(TermsLoading());
    try {
      (await _repository
              .getTermsPrivacyAboutRepository(endPoint: getTermsPath))
          .fold((Failure l) {
        emit(TermsCubitFailure());
      }, (ParentModel response) {
        _terms.add(response as TermPrivacyAboutModel);
      });

    } catch (e) {
      emit(TermsCubitFailure());
    }finally{
      emit(TermsLoaded());

    }
  }

  void changeTermExpanded(int index) {
    _terms[index].isExpanded = !_terms[index].isExpanded!;
    emit(TermsChangeExpanded(isExpanded:_terms[index].isExpanded!));
  }
}
