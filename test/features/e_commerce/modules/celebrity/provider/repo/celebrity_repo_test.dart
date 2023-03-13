import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/api/remote_celebrity_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/repo/remote_celebrity_list_repo.dart';

import '../../celebrity_values.dart';
import 'celebrity_repo_test.mocks.dart';


@GenerateMocks(<Type>[RemoteCelebrityApi])
void main() {
  late MockRemoteCelebrityApi mockRemoteCelebrityApi;

   late CelebrityRepo celebrityRepo;

  setUpAll(() {
    mockRemoteCelebrityApi = MockRemoteCelebrityApi();
    celebrityRepo = CelebrityRepo(mockRemoteCelebrityApi);
  });

  group('get all celebrities test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getCelebritiesValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: getCelebritiesValues.path)));

      when(mockRemoteCelebrityApi.getAllCelebrities())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getAllCelebrities(),
          isA<Right<Failure, ParentModel>>());
    });

    test('get all celebrities test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getCelebritiesValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getCelebritiesValues.path)));

      when(mockRemoteCelebrityApi.getAllCelebrities())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getAllCelebrities(),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('getVideos test', () {
    test('test on success', () async {
      final Map<String,dynamic> response = <String, dynamic>{
        "videosList":<dynamic>[]
      };

      when(mockRemoteCelebrityApi.getVideos())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getVideos(),
          isA<Right<Failure, List<Story>>>());
    });

    test('get all celebrities test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getCelebritiesValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getCelebritiesValues.path)));

      when(mockRemoteCelebrityApi.getAllCelebrities())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getAllCelebrities(),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('get single celebrity test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getSingleCelebrityValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: getSingleCelebrityValues.path)));

      when(mockRemoteCelebrityApi.getSingleCelebrity(celebrityUuid: "g534534524234324324"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getSingleCelebrityData(celebrityUuid: "g534534524234324324"),
          isA<Right<Failure, ParentModel>>());
    });

    test('get single celebrity test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getSingleCelebrityValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getSingleCelebrityValues.path)));

      when(mockRemoteCelebrityApi.getSingleCelebrity(celebrityUuid: "g5345dwdwd234324324"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await celebrityRepo.getSingleCelebrityData(celebrityUuid: "g5345dwdwd234324324"),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
