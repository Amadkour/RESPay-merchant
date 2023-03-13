import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/api/base_analytics_api.dart';

class JsonAnalyticsApi extends BaseAnalyticsApi {
  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> get() async {
    // final String response = await rootBundle.loadString('assets/jsons/home_manage_analytcs.json');

    // return jsonDecode(response) as Map<String, dynamic>;
    throw UnimplementedError();
  }
}
