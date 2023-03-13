import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/role_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/saving_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/transaction_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/role_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/saving_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/page/saving_page.dart';

part 'saving_state.dart';

class SavingCubit extends Cubit<SavingState> {
  SavingCubit(this._roleRepository, this._savingRepository)
      : super(SavingInitial()) {
    init();
  }

  final RoleRepository _roleRepository;
  final SavingRepository _savingRepository;

  /// Loading when opening the Page first time
  Future<void> init() async {
    emit(SavingLoadingState());
    try {
      await _getSavingModel();
    } catch (e) {
      MyToast('Something happened');
    } finally {
      emit(SavingLoadedState());
    }
  }

  /// ------------------------------ Initializations --------------------- ///
  /// ------------------ Primitive(bool,String....etc) Variables

  double totalMoney = 0;

  /// state for the activate/deactivate the wallet
  bool activationWalletSwitcher = false;

  /// ------------------- Non-primitive(Type of another class) Variables ---------------- ///
  SavingModel? _savingModel;
  List<RoleModel> roles = <RoleModel>[];
  List<TransactionSavingModel> savingTransactionModels =
      <TransactionSavingModel>[];

  ///------------------------ Controllers
  final TextEditingController addMoneyController = TextEditingController();
  final TextEditingController withdrawController = TextEditingController();
  final TextEditingController fromInvestingController = TextEditingController();
  final TextEditingController toInvestingController = TextEditingController();
  final TextEditingController saveInvestingController = TextEditingController();

  /// ---------------- BottomSheet Controllers
  final TextEditingController amountController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController saveController = TextEditingController();

  /// ------------------- Keys
  final GlobalKey<FormState> formKey = GlobalKey();

  /// ------------------- Focus Nodes
  final FocusNode toFocusNode = FocusNode();
  final FocusNode fromFocusNode = FocusNode();
  final FocusNode saveFocusNode = FocusNode();

  SavingModel get savingModel => _savingModel!;

  int get recentActivityInBeginningLength {
    return savingTransactionModels.length > 3
        ? 3
        : savingTransactionModels.length;
  }

  /// enable/disable bottom sheet button
  bool enableButtonSheetButton(String title) {
    if ((title == tr('add_money') || title == tr('withdraw')) &&
        amountController.text.isNotEmpty) {
      return true;
    } else if ((title == tr('update_role') ||
            title == tr('add_new_role_title')) &&
        (toController.text.isNotEmpty &&
            fromController.text.isNotEmpty &&
            saveController.text.isNotEmpty)) {
      return true;
    }
    return false;
  }

  /// update screen while tapping text to check validation
  void emitState() {
    emit(SavingUpdateScreen());
  }

  Future<void> submitBottomSheet(String title, int? roleIndex) async {
    /// Add Money
    if (title == tr('add_money')) {
      if (formKey.currentState!.validate()) {
        final String message = await addMoney(onBack: () {
          CustomNavigator.instance.pop();
        });
        if (message.isNotEmpty) {
          MyToast(message);
        }
      }
    }

    /// Withdraw
    else if (title == tr('Withdraw')) {
      if (formKey.currentState!.validate()) {
        final String message = await withdraw(onBack: () {
          CustomNavigator.instance.pop();
        });
        if (message.isNotEmpty) {
          MyToast(message);
        }
      }
    } else {
      if (double.parse(fromController.text) >=
          double.parse(toController.text)) {
        MyToast("'to' amount must be greater than 'From' amount");
      } else if (double.parse(saveController.text) >=
          double.parse(toController.text)) {
        MyToast("'to' amount must be greater than 'Save' amount");
      } else {
        /// Update Role
        if (title == tr('update_role')) {
          if (formKey.currentState!.validate()) {
            final String message = await updateRole(
                index: roleIndex!,
                onBack: () {
                  CustomNavigator.instance.pop();
                });
            if (message.isNotEmpty) {
              MyToast(message);
            }
          }
        }

        /// Add Role
        else {
          if (formKey.currentState!.validate()) {
            final String message = await addRole(onBack: () {
              CustomNavigator.instance.pop();
            });
            if (message.isNotEmpty) {
              MyToast(message);
            }
          }
        }
      }
    }
  }

  /// ------------------------------------ Methods UI Logic -----------------///

  bool isGreen(int index) {
    return savingTransactionModels[index].type!.toLowerCase() == 'deposit';
  }

  String transactionAmountText(int index) {
    return "${savingTransactionModels[index].type!.toLowerCase() == 'withdraw' ? '-' : ''} "
        "${savingTransactionModels[index].amount} ${tr('sar')}";
  }

  ///  Reload the page again like the first time
  ///  TODO: Refactor
  void reloadPage() {
    sl.unregister<SavingCubit>();
    sl.registerLazySingleton(
        () => SavingCubit(RoleRepository.instance, SavingRepository.instance));
    CustomNavigator.instance
        .pushReplacementWithoutAnimations(routeWidget: const SavingPage());
  }

  ///------------------ Part of [BottomSheet]
  void fillTextFieldWhileUpdateRole(
      {required int to, required int from, required int save}) {
    toController.text = to.toString();
    fromController.text = from.toString();
    saveController.text = save.toString();
  }

  void clearRolesControllers() {
    toController.text = '';
    fromController.text = '';
    saveController.text = '';
  }

  void clearAmountController() {
    amountController.text = '';
  }

  /// ------------------------------------ Repository API Methods -----------------///

  /// Get all the saving data in the beginning of the page
  /// part of [init]
  Future<void> _getSavingModel() async {
    try {
      await _savingRepository.getSavingModelsRepository();
      final SavingModel savingModel = _savingRepository.data;
      _savingModel = savingModel;
      totalMoney = savingModel.total!;
      savingTransactionModels = savingModel.transactions!;
      roles = savingModel.rules!;
      activationWalletSwitcher = savingModel.isActive!;
    } catch (e) {
      emit(SavingGetSavingModelFailure());
    }
  }

  /// Toggle wallet activate/deactivate Switcher
  Future<String> onChangeSwitcherValue({required bool newValue}) async {
    String message = '';
    try {
      (await _savingRepository.toggleSavingRepository()).fold((Failure l) {
        emit(SavingChangeSwitcherFailure());
        message = l.message;
      }, (Map<String, dynamic> r) {
        if (r['success'] as bool) {
          activationWalletSwitcher = newValue;
        }
      });
      emit(SavingChangeSwitcherState());
    } catch (e) {
      emit(SavingChangeSwitcherFailure());
    }
    return message;
  }

  /// -------------------------- Roles CRUD

  /// Delete Role
  Future<String> deleteRole({required int index}) async {
    String message = '';
    try {
      emit(SavingDeleteRoleLoadingState());
      (await _roleRepository.deleteRoleRepository(roleUUID: roles[index].uuid!))
          .fold((Failure l) {
        message = l.message;
        emit(SavingDeleteSavingModelFailure());
      }, (Map<String, dynamic> r) {
        roles.removeAt(index);
        message = 'Role deleted successfully';
      });
    } catch (e) {
      emit(SavingDeleteSavingModelFailure());
      message = 'Something went wrong';
    } finally {
      emit(SavingDeleteRoleLoadedState());
    }
    return message;
  }

  /// Toggle Role
  Future<String> toggleRole(
      {required int index, required VoidCallback onSuccess}) async {
    String message = '';
    try {
      emit(SavingToggleRoleLoadingState());
      (await _roleRepository.toggleRoleRepository(roleUUID: roles[index].uuid!))
          .fold((Failure l) {
        message = l.message;
        emit(SavingToggleRoleFailure());
      }, (Map<String, dynamic> r) {
        roles[index].isActive = !roles[index].isActive!;
        onSuccess.call();
        emit(SavingToggleRoleLoadedState());
      });
    } catch (e) {
      emit(SavingToggleRoleFailure());
      message = 'Something went wrong';
    }
    return message;
  }

  /// Add New Role
  Future<String> addRole({required VoidCallback onBack}) async {
    final double to = double.parse(toController.text);
    final double from = double.parse(fromController.text);
    final double value = double.parse(saveController.text);
    String message = '';

    /// Check that all fields > 0
    if (!(to <= 0 || from <= 0 || value <= 0)) {
      /// Check that Save text field value <= 100
      emit(SavingAddNewRoleLoading());
      try {
        (await _roleRepository.addRoleRepository(
                from: from, to: to, value: value))
            .fold((Failure l) {
          /// If error happened from the server
          message = 'Something error happened';
        }, (Map<String, dynamic> r) {
          /// Operation Succeeded
          roles.add(RoleModel.fromJson((r['data']
              as Map<String, dynamic>)['rule'] as Map<String, dynamic>));
          message = 'Role added Successfully';
        });
        emit(SavingAddNewRoleLoaded());
      } catch (e) {
        /// If anything not expected happened
        emit(SavingAddRoleFailure());
        message = 'Something error happened';
      }
    } else {
      /// Message if the user enter <= 0 in any field
      message = 'Please add a valid amount';
    }
    onBack.call();
    return message;
  }

  /// Update Role
  Future<String> updateRole(
      {required int index, required VoidCallback onBack}) async {
    String message = '';
    emit(SavingUpdateRoleLoading());
    try {
      (await _roleRepository.updateRoleRepository(
              roleUUID: roles[index].uuid!,
              to: double.parse(toController.text),
              value: double.parse(saveController.text),
              from: double.parse(fromController.text),
              isActive: roles[index].isActive! ? 1 : 0))
          .fold((Failure l) {
        emit(SavingUpdateRoleFailure());

        message = 'Something went wrong';
      }, (Map<String, dynamic> r) {
        roles[index].to = double.parse(toController.text).toInt();
        roles[index].form = double.parse(fromController.text).toInt();
        roles[index].value = double.parse(saveController.text).toInt();
        message = 'Role Updated Successfully';
      });
    } catch (e) {
      emit(SavingUpdateRoleFailure());
    } finally {
      emit(SavingUpdateRoleLoaded());
    }
    onBack();

    return message;
  }

  /// ------------------------- Deposit and Withdraw

  /// Deposit
  Future<String> addMoney({required VoidCallback onBack}) async {
    String message = '';
    if (double.parse(amountController.text) > 0) {
      emit(SavingButtonLoadingState());
      try {
        (await _savingRepository.addMoneyRepository(
                double.parse(amountController.removeNonNumber)))
            .fold((Failure l) {
          message = l.message;
        }, (Map<String, dynamic> r) {
          sl<TransactionHistoryCubit>().getWallet();

          savingTransactionModels.insert(
              0,
              TransactionSavingModel(
                amount: amountController.removeNonNumber,
                type: 'deposit',
                name: 'Saving',
                createdAt: DateTime.now(),
              ));
          totalMoney =
              totalMoney + double.parse(amountController.removeNonNumber);
          amountController.text = '';
          message = 'Money Added Successfully';
        });
      } catch (e) {
        emit(SavingAddMoneyFailure());
        message = 'Something happened';
      } finally {
        emit(SavingButtonLoadedState());
      }
    } else {
      message = 'Please add valid amount';
    }
    onBack.call();
    return message;
  }

  ///  Withdraw
  Future<String> withdraw({required VoidCallback onBack}) async {
    String message = '';
    final double amount = double.parse(amountController.text);
    if (amount > 0) {
      if (amount <= totalMoney) {
        emit(SavingButtonLoadingState());
        try {
          (await _savingRepository.withdraw(
            double.parse(
              amountController.text.replaceAll(',', ''),
            ),
          ))
              .fold((Failure l) {
            message = l.message;
          }, (Map<String, dynamic> r) {
            sl<TransactionHistoryCubit>().getWallet();

            savingTransactionModels.insert(
                0,
                TransactionSavingModel(
                  amount: amountController.text,
                  type: 'withdraw',
                  name: 'Saving',
                  createdAt: DateTime.now(),
                ));
            amountController.text = '';
            totalMoney = totalMoney - amount;

            message = 'Money transferred Successfully';
          });
        } catch (e) {
          emit(SavingWithdrawFailure());
          message = 'Something error happened';
        } finally {
          emit(SavingButtonLoadedState());
        }
      } else {
        message = "You don't have enough balance";
      }
    } else {
      message = 'Please add a valid amount';
    }
    onBack.call();
    return message;
  }
}
