import 'package:bloc/bloc.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_state.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/item_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/repos/more_repo.dart';

class MoreCubit extends Cubit<MoreState> {
  /// remove init state and add MoreLoadingState instead to load when reset dependencies after logout
  MoreCubit() : super(MoreLoadingState()) {
    init();
  }

  List<ItemModel>? accountItems;
  List<ItemModel>? settingsItems;
  final MoreRepo _repo = sl<MoreRepo>();

  void init() {
    getAllAssets();
  }

  Future<void> deleteSession() async {
    emit(MoreLoadingState());
    await sl<LocalStorageService>().removeSession();
    emit(SessionRemoved());
  }

  Future<void> getAllAssets() async {
    emit(MoreLoadingState());
    await getAccountList();
    await getHelpList();
    await getSettingsList();
    await getUpperListList();
    emit(MoreLoadedState());
  }

  Future<void> getAccountList() async {
    (await _repo.getAccountItems()).fold((Failure l) {
      emit(MoreErrorState());
    }, (List<ItemModel> r) {
      accountItems = r;
    });
  }

  Future<void> getSettingsList() async {
    (await _repo.getSettingsList()).fold((Failure l) {
      emit(MoreErrorState());
    }, (List<ItemModel> r) {
      settingsItems = r;
    });
  }

  List<ItemModel>? upperList;

  Future<void> getUpperListList() async {
    (await _repo.getUpperList()).fold((Failure l) {
      emit(MoreErrorState());
    }, (List<ItemModel> r) {
      upperList = r;
    });
  }

  List<ItemModel>? helpItems;

  Future<void> getHelpList() async {
    (await _repo.getHelpList()).fold((Failure l) {
      emit(MoreErrorState());
    }, (List<ItemModel> r) {
      helpItems = r;
    });
  }

  void rebuildScreenToUpdateLanguage() {
    emit(RebuildScreenToUpdateLanguage());
  }

  void resetStateAfterNavigate() {
    emit(MoreLoadingState());
  }
}
