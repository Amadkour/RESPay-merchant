// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CreateDepositInput with EquatableMixin {
  late String? walletUUID;
  late String? cardUUID;
  late String? type;
  late String? amount;
  final String? confirmationCode;
  CreateDepositInput({
    required this.walletUUID,
    required this.cardUUID,
    required this.type,
    required this.amount,
    this.confirmationCode,
  });

  FormData toMap() {
    return FormData.fromMap(<String, dynamic>{
      'wallet_uuid': walletUUID,
      'credit_card_uuid': cardUUID,
      'deposit_method': type,
      'amount': amount,
      "confirmation_code": confirmationCode,
    });
  }

  @override
  List<Object?> get props => <Object?>[walletUUID, cardUUID, type, amount];
}
