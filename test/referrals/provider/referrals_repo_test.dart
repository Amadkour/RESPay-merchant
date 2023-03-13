import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/api/referral/remote_referral_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/model/user_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/repo/remote_api_repo.dart';

import 'referrals_repo_test.mocks.dart';
@GenerateMocks(<Type>[
  RemoteReferralApi
])

void main() {
  late MockRemoteReferralApi mockRemoteReferralApi;

  late RemoteReferralApiRepo remoteReferralApiRepo;

  setUpAll(() {
    mockRemoteReferralApi = MockRemoteReferralApi();
    remoteReferralApiRepo = RemoteReferralApiRepo(mockRemoteReferralApi);
  });


  final List<Map<String,dynamic>> users  =<Map<String,dynamic>>[
    <String,dynamic>{"id": 1,
      "name": "hussein",
      "earnedMoney": 200
    },
    <String,dynamic>{"id": 2,
      "name": "ahmed",
      "earnedMoney": 100
    },
    <String,dynamic>{"id": 3,
      "name": "mohamed",
      "earnedMoney": 300
    },
    <String,dynamic> {
      "id": 4,
      "name": "ali",
      "earnedMoney": 400
    }
  ];
  group('get all referrals users test', () {

    test('get users success', () async {
      final Either<Failure, List<dynamic>> response = Right<Failure, List<dynamic>>(users);

      when(mockRemoteReferralApi.getUsers())
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await remoteReferralApiRepo.getUsers(),
          isA<Right<Failure, List<UserModel>>>());
    });

    test('get all referrals users failed', () async {
      const Either<Failure, List<dynamic>> response = Right<Failure, List<dynamic>>(<dynamic>[]);

      when(mockRemoteReferralApi.getUsers())
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await remoteReferralApiRepo.getUsers(),
          isA<Left<Failure, List<UserModel>>>());
    });
  });
}
