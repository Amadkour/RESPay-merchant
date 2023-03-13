import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/bank_account_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/gift_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/mobile_wallet_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/res_app_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/western_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_options_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer_options/transfer_options_repo.dart';

part 'transfer_options_state.dart';

class TransferOptionsCubit extends Cubit<TransferOptionsState> {
  final TransferOptionsRepo _repo;

  TransferOptionsCubit(this._repo) : super(TransferOptionsInitial()) {
    init();
  }

  Future<void> init() async {
    await get();
  }

  TransferMethodType currentMethodType = TransferResAppMethodType("RES App",2);
  TransferOptionsModel? transferOptions;
  List<String>? internationalTransferTypes;

  List<String> categoriesTypes() {
    return categories.map((TransferCategoryModel e) => e.name!).toList();
  }

  List<BudgetCategoryModel> categoriesModel = <BudgetCategoryModel>[];
  List<TransferCategoryModel> categories = <TransferCategoryModel>[];
  List<String>? localTransferTypes;
  String? currentPurpose;
  String? currentCategory;
  List<String>? walletNames;
  List<String>? categoriesList;

  void setCurrentPurpose(String value) {
    currentPurpose = value;
    emit(TransferTypeItemChosen());
  }

  void reset() {
    currentCategory = null;
    currentPurpose = null;
  }

  void setCurrentCategory(String value) {
    currentCategory = value;
    emit(TransferTypeItemChosen());
  }

  void setCurrentMethodType(String value) {
    switch (value.trim().toLowerCase().replaceAll(" ", "")) {
      case "resapp":
        currentMethodType = TransferResAppMethodType(value,2);
        break;
      case "westernunion":
        currentMethodType = TransferWesternMethodType(value,1);
        break;
      case "mobilewallet":
        currentMethodType = TransferMobileWalletMethodType(value,2);
        break;
      case "bankaccount":
        currentMethodType = TransferBankAccountMethodType(value,2);
        break;
      case "gift":
        currentMethodType = TransferGiftMethodType(value,1);
        break;
      default:
        currentMethodType = TransferResAppMethodType(value,2);
        break;
    }
    emit(TransferTypeItemChosen());
  }

  Future<Option<TransferOptionsModel>> get() async {
    // try {
    //
    // } catch (e) {
    //   emit(TransferOptionsErrorState(ApiFailure(message: "error happen")));
    //   return none();
    // }
    emit(TransferOptionsLoadingState());
    final Either<Failure, ParentModel> result = await _repo.get();
    return result.fold((Failure failure) {
      emit(TransferOptionsErrorState(failure));
      return none();
    }, (ParentModel r) {
      transferOptions = r as TransferOptionsModel;
      internationalTransferTypes = transferOptions!.externalTransferTypes;
      localTransferTypes = transferOptions!.internalTransferTypes;
      categories = transferOptions!.transferCategories ?? <TransferCategoryModel>[];
      categoriesList = categories.map((TransferCategoryModel e) => e.name!).toList();
      walletNames = transferOptions!.walletNames;
      emit(TransferOptionsLoadedState());
      return some(r);
    });
  }
}
