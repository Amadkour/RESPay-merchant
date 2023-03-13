import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_limit_state.dart';

class CardLimitCubit extends Cubit<CardLimitState> {
  CardLimitCubit() : super(CardLimitInitial()){
    init();
  }

 void init(){
    transactionSlider = transactionLimit;
    withdrawSlider = withdrawLimit;

  }
  double transactionSlider = 0.0;
  double withdrawSlider = 0.0;
  double transactionLimit = 0.0;
  double withdrawLimit = 0.0;

  void setValues(){
    transactionLimit =transactionSlider;
    withdrawLimit =withdrawSlider;
    emit(CardLimitChangeValues());
  }

  void changeTransactionSliderValue(double value) {
    transactionSlider = value;
    emit(CardLimitChangeSliderValue());
  }
  void changeWithdrawSliderValue(double value) {
    withdrawSlider = value;
    emit(CardLimitChangeSliderValue());
  }
}
