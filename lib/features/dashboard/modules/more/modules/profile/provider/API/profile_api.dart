import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/end_points.dart';

class ProfileAPI {
  APIConnection? apiConnection;

  ProfileAPI(this.apiConnection) {
    dio = apiConnection!.dio;
  }
  late Dio dio;
  ProfileAPI.withDio({Dio? dio}) {
    this.dio = dio!;
  }
  ProfileAPI._singleTone() {
    dio = APIConnection.instance.dio;
  }

  static final ProfileAPI _instance = ProfileAPI._singleTone();

  static ProfileAPI get instance => _instance;

  /// Show Profile
  Future<Either<Failure, Response<Map<String, dynamic>>>> showProfile() async {
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.get(showProfilePath);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure());
    }
  }

  /// Update Profile
  Future<Either<Failure, Response<Map<String, dynamic>>>> updateProfile({required Map<String, dynamic> inputs}) async {
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.post(
        updateProfilePath,
        data: FormData.fromMap(inputs),
      );
      if (inputs["phone_number"] != null) {
        await sl<LocalStorageService>().setUserPhone(inputs[userPhone] as String);
      }
      if (response.data!["otp"] != null) {
        MyToast(((response.data!['errors'] as Map<String, dynamic>)['otp'] as int).toString());
        await sl<LocalStorageService>().writeSecureKey(
            "verify_account_pin_code", ((response.data!['errors'] as Map<String, dynamic>)['otp'] as int).toString());
      }
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure());
    }
  }
}
