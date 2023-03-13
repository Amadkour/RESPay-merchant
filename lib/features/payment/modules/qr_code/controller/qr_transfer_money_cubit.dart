import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_transfer_money_state.dart';

class QrTransferMoneyCubit extends Cubit<QrTransferMoneyState> {
  QrTransferMoneyCubit() : super(QrTransferMoneyInitial());
}
