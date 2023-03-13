// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/model/bank_account.dart';

class ReceiptModel {
  final String id;
  final DateTime date;
  final String amount;
  final String type;
  final Beneficiary? beneficiary;
  final String? purpose;
  final String? notes;
  final String? fees;
  final String? discount;
  final BankAccounts? bankAccount;
  final CreditCardModel? cardModel;
  ReceiptModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    this.beneficiary,
    this.purpose,
    this.notes,
    this.fees,
    this.discount,
    this.bankAccount,
    this.cardModel,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json, String type) {
    final Map<String, dynamic> typeMap =
        (json[type] as Map<String, dynamic>?) ??
            json['transaction'] as Map<String, dynamic>;
    return ReceiptModel(
      id: (typeMap['uuid'] ?? typeMap['reference_number']) as String,
      date: DateTime.parse(
          (typeMap['created_at'] ?? typeMap['credted_at']) as String),
      amount: typeMap['amount'].toString(),
      type: type,
      fees: typeMap['fee']?.toString() ?? "0",
      discount: typeMap['discount']?.toString() ?? "0",
      notes: typeMap['notes'] as String?,
      purpose: typeMap['purpose'] as String?,
    );
  }

  ReceiptModel copyWith({
    String? id,
    DateTime? date,
    String? amount,
    String? type,
    Beneficiary? beneficiary,
    String? purpose,
    String? notes,
    String? fees,
    String? discount,
    BankAccounts? bankAccount,
    CreditCardModel? cardModel,
  }) {
    return ReceiptModel(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      beneficiary: beneficiary ?? this.beneficiary,
      purpose: purpose ?? this.purpose,
      notes: notes ?? this.notes,
      fees: fees ?? this.fees,
      discount: discount ?? this.discount,
      bankAccount: bankAccount ?? this.bankAccount,
      cardModel: cardModel ?? this.cardModel,
    );
  }

  @override
  String toString() {
    return 'ReceiptModel(id: $id, date: $date, amount: $amount, type: $type, beneficiary: $beneficiary, purpose: $purpose, notes: $notes, fees: $fees, discount: $discount, bankAccount: $bankAccount, cardModel: $cardModel)';
  }
}
