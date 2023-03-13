import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/remote_celebrity_api.dart';

import '../../../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../celebrity_values.dart';

void main(){
  late MockDio mockedDio;
  late RemoteCelebrityApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = RemoteCelebrityApi.withDio(dio: mockedDio);
  });

  group("get videos", () {
    test('getAllCelebrities Failed Test', () async {
      when(mockedDio.get(getCelebritiesValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getCelebritiesValues.failureResponse,
          requestOptions: RequestOptions(
            path: getCelebritiesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getAllCelebrities();
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("getAllCelebrities", () {
    test('getAllCelebrities Test', () async {
      when(mockedDio.get(getCelebritiesValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getCelebritiesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getCelebritiesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getAllCelebrities();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getAllCelebrities Failed Test', () async {
      when(mockedDio.get(getCelebritiesValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getCelebritiesValues.failureResponse,
          requestOptions: RequestOptions(
            path: getCelebritiesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getAllCelebrities();
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("getSingleCelebrity", () {
    test('getSingleCelebrity Test', () async {
      when(mockedDio.get(getSingleCelebrityValues.path,queryParameters: <String,dynamic>{
        "celebrity_uuid":"a7db9bd9-fb48-3cc9-8049-512da4b839b0"
      })).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getSingleCelebrityValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getSingleCelebrityValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getSingleCelebrity(celebrityUuid: "a7db9bd9-fb48-3cc9-8049-512da4b839b0");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getSingleCelebrity Failed Test', () async {
      when(mockedDio.get(getSingleCelebrityValues.path,queryParameters: <String,dynamic>{
        "celebrity_uuid":"a7db9bd9-fb48-3cc9-8049"
      })).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getSingleCelebrityValues.failureResponse,
          requestOptions: RequestOptions(
            path: getSingleCelebrityValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getSingleCelebrity(celebrityUuid: "a7db9bd9-fb48-3cc9-8049");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
