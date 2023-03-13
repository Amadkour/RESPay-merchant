// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class HistoryFilterInput extends Equatable {
  Map<String, dynamic> toMap();
}

class HistorySearchInput extends HistoryFilterInput {
  final String referenceNumber;

  HistorySearchInput(this.referenceNumber);
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "reference_number": referenceNumber,
    };
  }

  @override
  List<Object?> get props => <Object?>[referenceNumber];
}

class HistoryCategoryFilterInput extends HistoryFilterInput {
  final String type;

  HistoryCategoryFilterInput(this.type);
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "type": type,
    };
  }

  @override
  List<Object?> get props => <Object?>[type];
}

class HistoryPeriodFilterInput extends HistoryFilterInput {
  final String? from;
  final String? to;
  final String? period;
  HistoryPeriodFilterInput({
    this.from,
    this.to,
    this.period,
  });
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      "period": period,
    };
    if (from != null) {
      map['from'] = from;
    }
    if (to != null) {
      map['to'] = to;
    }

    return map;
  }

  @override
  List<Object?> get props => <Object?>[from, to, period];
}
