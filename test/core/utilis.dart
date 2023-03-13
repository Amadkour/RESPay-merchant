import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

dynamic compareInputs(FormData expectedInput) {
  return captureThat(
    isA<FormData>().having(
      (FormData body) =>
          body.fields.map((MapEntry<String, dynamic> e) => e.value),
      'compare inputs',
      expectedInput.fields.map((MapEntry<String, dynamic> e) => e.value),
    ),
  );
}

dynamic compare(FormData expectedInput) {
  if ((captureAnyNamed('data')) == expectedInput) {
    return captureAnyNamed('data');
  }
}

dynamic compareMapInputs(Map<String, dynamic> expectedInput) {
  return captureThat(
    isA<Map<String, dynamic>>().having(
      (Map<String, dynamic> params) => params.values,
      'compare inputs',
      expectedInput.values,
    ),
  );
}
