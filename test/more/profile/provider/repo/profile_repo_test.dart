// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:res_pay_merchant/core/errors/failures.dart';
// import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
// import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/api/profile_api.dart';
// import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';
//
// import '../../profile_values.dart';
// import 'profile_repo_test.mocks.dart';
//
// @GenerateMocks(<Type>[
//   ProfileAPI,
// ])
// void main() {
//   late MockProfileAPI mockProfileAPI;
//
//   late ProfileRepository profileRepository;
//
//   setUpAll(() {
//     mockProfileAPI = MockProfileAPI();
//     profileRepository = ProfileRepository(mockProfileAPI);
//   });
//
//   group('show profile test', () {
//     test('show profile test on success', () async {
//       final Either<Failure, Response<Map<String, dynamic>>> response =
//           Right<Failure, Response<Map<String, dynamic>>>(
//               Response<Map<String, dynamic>>(
//                   data: showProfileValues.successfulResponse,
//                   statusCode: 201,
//                   requestOptions:
//                       RequestOptions(path: showProfileValues.path)));
//
//       when(mockProfileAPI.showProfile())
//           .thenAnswer((Invocation realInvocation) async => response);
//       expect(await profileRepository.showProfileRepository(),
//           isA<Right<Failure, ParentModel>>());
//     });
//
//     test('show profile test on Failure', () async {
//       final Either<Failure, Response<Map<String, dynamic>>> response =
//           Right<Failure, Response<Map<String, dynamic>>>(
//               Response<Map<String, dynamic>>(
//                   data: showProfileValues.failureResponse,
//                   statusCode: 404,
//                   requestOptions:
//                       RequestOptions(path: showProfileValues.path)));
//
//       when(mockProfileAPI.showProfile())
//           .thenAnswer((Invocation realInvocation) async => response);
//       expect(await profileRepository.showProfileRepository(),
//           isA<Left<Failure, ParentModel>>());
//     });
//   });
//
//   group('update profile test', () {
//     test('update profile test on success', () async {
//       final Either<Failure, Response<Map<String, dynamic>>> response =
//           Right<Failure, Response<Map<String, dynamic>>>(
//               Response<Map<String, dynamic>>(
//                   data: updateProfileValues.successfulResponse,
//                   statusCode: 201,
//                   requestOptions:
//                       RequestOptions(path: updateProfileValues.path)));
//
//       when(mockProfileAPI.updateProfile(inputs: updateProfileSuccessInput))
//           .thenAnswer((Invocation realInvocation) async => response);
//       expect(
//           await profileRepository.updateProfileRepository(
//               inputs: updateProfileSuccessInput),
//           isA<Right<Failure, ParentModel>>());
//     });
//
//     test('update profile test on Failure', () async {
//       final Either<Failure, Response<Map<String, dynamic>>> response =
//           Right<Failure, Response<Map<String, dynamic>>>(
//               Response<Map<String, dynamic>>(
//                   data: updateProfileValues.failureResponse,
//                   statusCode: 404,
//                   requestOptions:
//                       RequestOptions(path: updateProfileValues.path)));
//
//       when(mockProfileAPI.updateProfile(inputs: updateProfileFailureInput))
//           .thenAnswer((Invocation realInvocation) async => response);
//       expect(
//           await profileRepository.updateProfileRepository(
//               inputs: updateProfileFailureInput),
//           isA<Left<Failure, ParentModel>>());
//     });
//   });
// }
