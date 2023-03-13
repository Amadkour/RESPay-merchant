part of 'cards_cubit.dart';

abstract class CardsState extends Equatable {}

class CardsInitial extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsLoading extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}
class CreateCardLoading extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class GetPaymentMethodsLoading extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsFailure extends CardsState {
  final Failure failure;

  CardsFailure(this.failure);

  @override
  List<Object?> get props => <Object>[failure];
}

class GetPaymentMethodsFailure extends CardsState {
  final Failure failure;

  GetPaymentMethodsFailure(this.failure);

  @override
  List<Object?> get props => <Object>[failure];
}

class CardsPaymentMethodsLoaded extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsDeleteCardFailure extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsCreateCardFailure extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsPaymentMethodsFailure extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardCreatedState extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardDeletedState extends CardsState {
  final int index;

  CardDeletedState(this.index);

  @override
  List<Object?> get props => <Object>[index];
}

class CardsPageChanged extends CardsState {
  final int index;

  CardsPageChanged(this.index);

  @override
  List<Object?> get props => <Object>[index];
}

class CardsCubitLoaded extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsCubitChangeTapBarIndex extends CardsState {
  final int index;
  CardsCubitChangeTapBarIndex({required this.index});

  @override
  List<Object?> get props => <Object>[index];
}

class CardsCubitToggleSwitcherLockCard extends CardsState {
  final bool enabled;
  CardsCubitToggleSwitcherLockCard({required this.enabled});

  @override
  List<Object?> get props => <Object>[enabled];
}
class CardsCubitToggleSwitcherNFC extends CardsState {
  final bool enabled;
  CardsCubitToggleSwitcherNFC({required this.enabled});

  @override
  List<Object?> get props => <Object>[enabled];
}
class CardsCubitToggleSwitcherOnline extends CardsState {
  final bool enabled;
  CardsCubitToggleSwitcherOnline({required this.enabled});

  @override
  List<Object?> get props => <Object>[enabled];
}
class CardsCubitToggleSwitcherPIN extends CardsState {
  final bool enabled;
  CardsCubitToggleSwitcherPIN({required this.enabled});

  @override
  List<Object?> get props => <Object>[enabled];
}

class CardsCubitGetCardsFailure extends CardsState {
  @override
  List<Object?> get props => <Object>[];
}

class CardsCubitChangeCardVisibility extends CardsState {
  final bool value;

  CardsCubitChangeCardVisibility({required this.value});

  @override
  List<Object?> get props => <Object>[value];
}

class CardInfoChanged extends CardsState {
  final String string;

  CardInfoChanged(this.string);
  @override
  List<Object?> get props => <String>[string];
}
