import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

part 'hom_state.dart';

class HomCubit extends BaseCubit<HomeState> {
  HomCubit() : super(HomInitial()) {
    onInit();
  }

  List<CreditCardModel>? homeCards = <CreditCardModel>[];

  /// I Commented it because data is already loaded in
  /// transaction history cubit no need to load it here

  // List<TransactionModel> homeTransactions = <TransactionModel>[];

  // String totalWallet = '0';
  String? userName = '';
  String? imageUrl = '';

  Future<void> refreshHomeScreenData() async {
    await sl<ProfileRepository>().showProfileRepository();
    putNewDate();
  }

  void putNewDate() {
    userName = sl<ProfileRepository>().data!.fullName;
    imageUrl = sl<ProfileRepository>().data!.imageUrl;
    emit(HomeRefreshDataSate());
  }

  Future<void> onInit() async {
    if (await sl<LocalStorageService>().containSecureKey(userToken)) {
      emit(HomeLoading());
      try {
        await sl<LocalStorageService>().writeSecureKey("already_opened", "true");
        (await sl<ProfileRepository>().showProfileRepository()).fold((Failure l) {
          MyToast(l.errors['otp'].toString());
          CustomNavigator.instance.pushNamed(RoutesName.otp, arguments: () async {
            await sl<LocalStorageService>().writeSecureKey("already_opened", "false");
            await refreshHomeScreenData();
            CustomNavigator.instance.pop();
          });
        }, (ParentModel profile) async {
          await sl<LocalStorageService>().writeSecureKey("already_opened", "false");

          /// normal flow
          userName = (profile as ProfileModel).fullName;
          imageUrl = profile.imageUrl;
        });
      } catch (e) {
        emit(HomeFailure());
        MyToast(e.toString());
      }

      ///
      try {
        (await CardsSectionRepository.instance.getCardsRepository()).fold((Failure l) {}, (List<CreditCardModel> r) {
          homeCards = r;
        });
      } catch (e) {
        emit(HomeFailure());
        MyToast(e.toString());
      }
      emit(HomeLoaded());
    } else {
      userName = tr('sir');
    }
  }

  @override
  Future<void> onRefresh() async {
    await onInit();
  }
}
