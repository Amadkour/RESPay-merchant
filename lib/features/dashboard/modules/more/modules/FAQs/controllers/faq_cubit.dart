import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/model/faq_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/repository/faq_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/page/faq_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit({FaqModel? faqs, String? title}) : super(FreqLoading()) {
    if (faqs != null) {
      faqData = faqs;
      pageTitle = title;
      emit(FreqLoaded());
    } else {
      userName = sl<ProfileRepository>().data?.fullName;
      onInit();
    }
  }
  TextEditingController searchBarController = TextEditingController();
  void resetSearchBar(){
    searchBarController.clear();
    query ="";
    faqFilteredList;
    emit(ResetSearchbar());
  }

  String? searchText;
  String? pageTitle;
  late FaqModel faqData;
  String? userName = '';
  String query = '';

  Future<void> onInit() async {
    await sl<ProfileRepository>().showProfileRepository();
    (await FAQsRepo.instance.getFAQs()).fold((Failure l) {
      faqData = FaqModel(feq: <Faqs>[]);
      emit(FAQFailureSate(l.errors.toString()));
    }, (ParentModel r) {
      faqData = r as FaqModel;
      emit(FreqLoaded());
    });
  }

  Future<void> onClick(int index) async {
    if (faqData.faqs[index].subFaqs.isNotEmpty) {
      ///push new screen by sub questions
      CustomNavigator.instance.push(
          routeWidget: FAQsPage(
        faqs: faqData..faqs = faqData.faqs[index].subFaqs,
        title: faqData.faqs[index].question,
      ));
    } else {
      faqData.faqs[index].isOpen = !faqData.faqs[index].isOpen;
    }
    emit(FreqLoaded());
  }

  List<Faqs> get faqFilteredList {
    final FaqModel faqList = faqData;
    if (query.isEmpty) {
      return faqList.faqs;
    } else {
      return faqList.faqs.where((Faqs element) => (element.question ?? '').contains(query.toLowerCase())).toList();
    }
  }

  void onChangeSearch(String value) {
    query = value;
    emit(FreqLoaded());
  }
}
