import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyalty_list_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/repo/customer_repo.dart';

part 'customer_loyalty_state.dart';

class CustomerLoyaltyCubit extends BaseCubit<CustomerLoyaltyState> {
  CustomerLoyaltyCubit({CustomerLoyaltyRepo? repo})
      : super(CustomerLoyaltyLoading()) {
    _repo = repo ?? sl<CustomerLoyaltyRepo>();
    canRefresh = true;
    onInit();
  }

  CustomerLoyaltyListModel? loyaltyModel;

  List<CustomerLoyaltyModel> get customerList =>
      loyaltyModel?.list ?? <CustomerLoyaltyModel>[];
  late CustomerLoyaltyRepo _repo;
  CustomerLoyaltyModel? selectedCustomerLoyalty;

  Future<void> onInit() async {
    emit(CustomerLoyaltyLoading());
    final Either<Failure, ParentModel> result = await _repo.getLoyalties();
    result.fold((Failure l) {
      emit(CustomerLoyaltyError(l));
    }, (ParentModel r) {
      loyaltyModel = r as CustomerLoyaltyListModel;
      emit(CustomerLoyaltyLoaded());
    });
  }

  Future<void> show(CustomerLoyaltyModel shop) async {
    selectedCustomerLoyalty = shop;
    emit(ShowCustomerLoyaltyLoading());

    final Either<Failure, CustomerLoyaltyModel> result =
        await _repo.show(shop.uuid!);
    result.fold((Failure l) {
      emit(CustomerLoyaltyError(l));
    }, (CustomerLoyaltyModel r) {
      selectedCustomerLoyalty = r;
      emit(CustomerLoyaltyLoaded());
    });
  }

  Future<String> redeem() async {
    emit(RedeemCustomerLoyaltyLoading());
    final Either<Failure, String> result =
        await _repo.redeem(selectedCustomerLoyalty!.uuid!);
    return result.fold((Failure l) {
      emit(CustomerLoyaltyRedeemError(l));
      return l.message;
    }, (String r) {
      emit(CustomerLoyaltyRedeemed());
      return r;
    });
  }

  void oChangRate(int newRate) {
    // change rate and save new rate to list
    // customerList = customerList..[selectedIndex!].rate = newRate;
    emit(CustomerLoyaltyChangeRate());
  }

  @override
  Future<void> onRefresh() async {
    onInit();
  }
}
