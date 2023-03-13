import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';

part 'cards_credit_card_state.dart';

class CardsCreditCardCubit extends Cubit<CardsCreditCardState> {
  CardsCreditCardCubit({List<CreditCardModel>? creditCardModels})
      : super(CardsCreditCardInitial()) {
    creditCards = creditCardModels!;
    init();
  }



  int cardsIndex = 0;

  /// Change index for Cards Page View
 void onPageChanged(int newIndex) {
    cardsIndex = newIndex;
    emit(CardsCreditCardPageChanged());
  }

  List<CreditCardModel> creditCards = <CreditCardModel>[];
  List<bool> creditCardsVisible = <bool>[];

  void init() {
    for (int i = 0; i < creditCards.length; i++) {
      // TODO: Refactor
      creditCardsVisible.add(false);
    }
  }

  void onChangeVisibility(int newIndex) {
    creditCardsVisible[newIndex] = !creditCardsVisible[newIndex];
    emit(CardsCreditChangeVisibility());
  }
}
