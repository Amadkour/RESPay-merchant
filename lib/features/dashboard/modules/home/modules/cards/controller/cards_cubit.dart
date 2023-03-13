import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/transaction_global_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/provider/model/limits_model.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/create_card_input.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit(this._repository) : super(CardsInitial()) {
    init();
  }

  final CardsSectionRepository _repository;

  //-------card data-----//

  String cvv = '';
  String holderName = '';
  String date = '';
  String number = '';
  String methodUuid = 'e6a7908a-f702-3a74-a6dc-8c8a82803627';
  final GlobalKey<FormState> cardKey = GlobalKey<FormState>();

  //------end cardData-----//

  /// Initialization
  int index = 0;
  int tapBarIndex = 0;

  /// Switchers variables
  bool lockCard = false;
  bool enableNFC = false;
  bool enableOnlinePayments = false;
  bool enableCardPin = false;

  late PageController pageViewController;

  /// Focus Nodes
  final FocusNode cardNumberFocusNode = FocusNode();
  final FocusNode cvvFocusNode = FocusNode();
  final FocusNode validUntilFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  /// Fetched Data
  LimitsModel limitsModel = LimitsModel();
  List<TransactionGlobalModel> transactionModels = <TransactionGlobalModel>[];

  List<PaymentMethod> paymentMethods = <PaymentMethod>[];

  final GlobalKey<FormState> createCardKey = GlobalKey<FormState>();

  bool get enableCreateCardButton {
    return holderName.isNotEmpty &&
        date.length == 7 &&
        number.length == 19 &&
        cvv.length == 3;
  }

  /// Switchers toggles
  void toggleLockCard() {
    lockCard = !lockCard;
    emit(CardsCubitToggleSwitcherLockCard(enabled: lockCard));
  }

  void toggleNFC() {
    enableNFC = !enableNFC;
    emit(CardsCubitToggleSwitcherNFC(enabled: enableNFC));
  }

  void toggleOnlinePayments() {
    enableOnlinePayments = !enableOnlinePayments;
    emit(CardsCubitToggleSwitcherOnline(enabled: enableOnlinePayments));
  }

  void toggleCardPin() {
    enableCardPin = !enableCardPin;
    emit(CardsCubitToggleSwitcherPIN(enabled: enableCardPin));
  }

  /// TabBar change index
  void onChangeTabBarIndex() {
    tapBarIndex = tapBarIndex == 0 ? 1 : 0;
    emit(CardsCubitChangeTapBarIndex(index: tapBarIndex));
  }

  /// Change index for Cards Page View
  void onPageChanged(int newIndex) {
    index = newIndex;
    emit(CardsPageChanged(index));
  }

  List<CreditCardModel> creditCardModels = <CreditCardModel>[];
  List<bool> creditCardsVisible = <bool>[];

  List<bool> get cardsVisible => creditCardsVisible;

  Future<void> init({int? newIndex}) async {
    emit(CardsLoading());
    index = newIndex ?? 0;

    ///----------get payment method
    await getPaymentMethods();

    pageViewController = PageController(initialPage: index);
    limitsModel = await _repository.getAllLimits();
    transactionModels = await _repository.getAllTransactions();
    await getCards();
  }

  void onChangeCardVisibility(int newIndex) {
    creditCardsVisible[newIndex] = !creditCardsVisible[newIndex];
    emit(CardsCubitChangeCardVisibility(value: creditCardsVisible[newIndex]));
  }

  //----setters for card information---//

  void setCvv(String cvv) {
    this.cvv = cvv;
    emit(CardInfoChanged(cvv));
  }

  void setCardNumber(String number) {
    this.number = number;
    emit(CardInfoChanged(number));
  }

  void setHolderName(String name) {
    holderName = name;
    emit(CardInfoChanged(name));
  }

  void setExpireDate(String expireDate) {
    date = expireDate;
    emit(CardInfoChanged(expireDate));
  }

  /// TODO: Refactor
  /// Get Cards From Repository
  Future<void> getCards() async {
    try {
      (await _repository.getCardsRepository()).fold((Failure l) {
        MyToast('Something went wrong');
      }, (List<CreditCardModel> response) async {
        creditCardModels = response;
        sl<HomCubit>().homeCards = response;
        for (int i = 0; i < creditCardModels.length; i++) {
          creditCardsVisible.add(false);
        }

        emit(CardsCubitLoaded());
      });
    } catch (e) {
      emit(CardsCubitGetCardsFailure());
    }
  }

  //-----his function responsible to get available payment methods----///

  Future<void> getPaymentMethods() async {
    try {
      emit(GetPaymentMethodsLoading());

      final Either<Failure, List<PaymentMethod>> result =
          await _repository.getPaymentMethods();
      result.fold(
        (Failure l) {
          emit(GetPaymentMethodsFailure(l));
        },
        (List<PaymentMethod> r) {
          paymentMethods = r;
          methodUuid = paymentMethods[1].uuid;
          emit(CardsPaymentMethodsLoaded());
        },
      );
    } catch (e) {
      emit(CardsPaymentMethodsFailure());
    }
  }

  //-----his function responsible to add new card to user Account----///

  Future<void> createCard() async {
    try {
      emit(CreateCardLoading());
      methodUuid = paymentMethods
          .firstWhere((PaymentMethod element) => element.slug == 'credit-card')
          .uuid;
      final CreateCardInput params = CreateCardInput(
        methodUUId: methodUuid,
        name: holderName,
        number: number.replaceAll(RegExp(r"\D"), ''),
        date: date,
        cvv: cvv,
      );
      final Option<Failure> result = await _repository.createCard(params);
      result.fold(() async {
        emit(CardCreatedState());
        await getCards();
      }, (Failure a) {
        emit(CardsFailure(a));
      });
    } catch (e) {
      emit(CardsCreateCardFailure());
    }
  }

  //-----his function responsible to delete card from user Account----///

  /// TODO: Refactor
  Future<void> deleteCard(int deletedIndex) async {
    try {
      emit(CardsLoading());
      final CreditCardModel card = creditCardModels[deletedIndex];
      final Option<Failure> result = await _repository.deleteCard(
        card.uuid!,
      );

      result.fold(() {
        // creditCardModels.removeAt(deletedIndex);
        // pageViewController.jumpToPage(0);
        // deletedIndex = 0;
        /// TODO: Refactor
        index = 0;

        creditCardModels.removeAt(deletedIndex);
        sl<HomCubit>().homeCards = creditCardModels;
        CustomNavigator.instance.pop();
        MyToast(tr('card_deleted'));
        emit(CardDeletedState(index));
      }, (Failure a) {
        emit(CardsFailure(a));
      });
    } catch (e) {
      emit(CardsDeleteCardFailure());
    }
  }

  void resetCardValues() {
    date = '';
    date = '';
    holderName = '';
    number = '';
  }
}
