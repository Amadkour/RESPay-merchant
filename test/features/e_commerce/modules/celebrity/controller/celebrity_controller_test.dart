
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrities_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/single_celebrity_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/repo/remote_celebrity_list_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:video_player/video_player.dart';

import 'celebrity_controller_test.mocks.dart';



@GenerateMocks(<Type>[
  CelebrityRepo,
  AudioPlayer,
  VideoPlayerController
])
void main() {
  final MockVideoPlayerController mockVideoPlayerController =MockVideoPlayerController();
  group('Celebrity Cubit test', () {
    late MockCelebrityRepo mockCelebrityRepo;
    mockCelebrityRepo = MockCelebrityRepo();
    setUpAll(() {
      mockCelebrityRepo = MockCelebrityRepo();
      when(mockCelebrityRepo.getAllCelebrities()).thenAnswer(
              (Invocation realInvocation) async =>
              Right<Failure, ParentModel>(CelebritiesModel()));
    });

    blocTest<CelebrityCubit, CelebrityState>(
      'get videos method',
      build: () {
        when(mockCelebrityRepo.getVideos()).thenAnswer(
                (Invocation realInvocation) async =>
            const Right<Failure, List<Story>>(<Story>[]));

        return CelebrityCubit(mockCelebrityRepo);
      },
      act: (CelebrityCubit bloc) async {
        await bloc.getVideos();
      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<CelebrityFailure>(),
        isA<VideoListLoaded>(),
      ],
    );
    blocTest<CelebrityCubit, CelebrityState>(
      'getAllCelebrities method',
      build: () {
        when(mockCelebrityRepo.getAllCelebrities()).thenAnswer(
                (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(CelebritiesModel(celebrity: <Celebrity>[
                  Celebrity(id: "dasdas")
                ])));

        return CelebrityCubit(mockCelebrityRepo);
      },
      act: (CelebrityCubit bloc) async {
        await bloc.getAllCelebrities();
      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<CelebrityLoading>(),
        isA<VideoListLoaded>(),
        isA<VideoListLoaded>(),
      ],
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'getSingleCelebrityData method',
      build: () {
        when(mockCelebrityRepo.getSingleCelebrityData(celebrityUuid: "asdasd234324324")).thenAnswer(
                (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(SingleCelebrityData(products: <ProductModel>[ProductModel()],celebrity: Celebrity(),banners: <Banners>[Banners()])));

        return CelebrityCubit(mockCelebrityRepo);
      },
      act: (CelebrityCubit bloc) async {
        await bloc.getCelebrityProducts(celebrityUuid: "asdasd234324324");
      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<CelebrityDetailLoading>(),
        isA<CelebrityDetailLoadedState>(),
        isA<VideoListLoaded>(),
      ],
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that search method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) {
        bloc.search("test");
      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<CelebritySearched>(),
        isA<VideoListLoaded>(),
      ],
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that closePlayer method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) {
        bloc.player=MockAudioPlayer();
        bloc.closePlayer();
      },
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that pause method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) {
        bloc.controller=mockVideoPlayerController;
        bloc.pause();
      },
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that closeVideoPlayer method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) async {
        bloc.controller=mockVideoPlayerController;
        if (VideoPlayerValue(duration: const Duration(seconds: 2)).isPlaying) {
          await bloc.controller.pause();
        }
      },
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that closeControllers method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) async {
        bloc.controller=mockVideoPlayerController;
        bloc.player=MockAudioPlayer();
        if (bloc.player != null) {
          bloc.player!.stop();
          bloc.player = null;
        }
        if (VideoPlayerValue(duration: const Duration(seconds: 2)).isPlaying) {
          await bloc.controller.pause();
        }
      },
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that changeGender method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) {
        bloc.changeGender(CelebrityGender.men);
      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<CelebrityGenderFilterChanged>(),
        isA<VideoListLoaded>(),
      ],
    );

    blocTest<CelebrityCubit, CelebrityState>(
      'verify that create method works correctly',
      build: () => CelebrityCubit(mockCelebrityRepo),
      act: (CelebrityCubit bloc) async{

      },
      expect: () => <TypeMatcher<CelebrityState>>[
        isA<VideoListLoaded>(),
      ],
    );
  });
}
