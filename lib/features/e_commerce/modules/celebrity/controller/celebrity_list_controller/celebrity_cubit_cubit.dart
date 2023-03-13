import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrities_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/single_celebrity_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/repo/remote_celebrity_list_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CelebrityCubit extends Cubit<CelebrityState> {
  CelebrityCubit(this._repo) : super(CelebrityInitial()) {
    getAllCelebrities();
    // getVideos();
  }

  void resetSearchBar() {
    query = "";
    emit(SearchBarResetState());
  }

  CelebrityGender genderFilter = CelebrityGender.allCelebrity;
  final CelebrityRepo _repo;

  List<Celebrity> _celebrityList = <Celebrity>[];
  List<Story> videoShopList = <Story>[];

  String query = '';

  AudioPlayer? player;
  late VideoPlayerController controller;

  List<Celebrity> get celebrityList {
    List<Celebrity> celebrities = <Celebrity>[];
    if (genderFilter == CelebrityGender.allCelebrity) {
      celebrities = _celebrityList;
    } else {
      celebrities = _celebrityList
          .where((Celebrity element) => element.gender == genderFilter)
          .toList();
    }

    if (query.isEmpty) {
      return celebrities;
    } else {
      return celebrities
          .where((Celebrity element) =>
              element.name!.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
  }

  List<ProductModel>? products;
  List<Banners> banners = <Banners>[];

  /// tested
  Future<void> getCelebrityProducts({required String celebrityUuid}) async {
    emit(CelebrityDetailLoading());
    final Either<Failure, ParentModel> result =
        await _repo.getSingleCelebrityData(celebrityUuid: celebrityUuid);
    result.fold(
      (Failure l) {
        emit(CelebrityDetailErrorState());
      },
      (ParentModel r) {
        products = (r as SingleCelebrityData).products;
        banners = r.banners!;
        emit(CelebrityDetailLoadedState());
      },
    );
  }

  /// tested
  void changeGender(CelebrityGender gender) {
    genderFilter = gender;
    emit(CelebrityGenderFilterChanged(gender));
  }

  /// tested
  Future<void> getAllCelebrities() async {
    try {
      emit(CelebrityLoading());
      final Either<Failure, ParentModel> result =
          await _repo.getAllCelebrities();
      result.fold(
        (Failure l) {
          emit(CelebrityFailure(l));
        },
        (ParentModel r) {
          _celebrityList = (r as CelebritiesModel).celebrity!;
          getVideos();
        },
      );
    } catch (_) {
      emit(CelebrityFailure(ApiFailure()));
    }
  }

  /// tested
  Future<void> getVideos() async {
    emit(CelebrityLoading());
    final Either<Failure, List<Story>> result = await _repo.getVideos();
    result.fold((Failure l) {
      emit(CelebrityFailure(l));
    }, (List<Story> r) {
      videoShopList = r;
      emit(VideoListLoaded());
    });
  }

  /// tested
  void search(String query) {
    this.query = query;
    emit(CelebritySearched(query));
  }

  Future<void> initSound(String path) async {
    player = AudioPlayer();
    if (player?.playing == true) {
      await player?.stop();
    }
    await player?.setAsset(path);
    await player?.play();
  }

  /// tested
  Future<void> closePlayer() async {
    if (player != null) {
      player!.stop();
      player = null;
    }
  }

  Future<void> initVideo(String path, {bool start = true}) async {
    controller = VideoPlayerController.network(path);
    await controller.initialize();
    emit(CelebrityVideoLoaded(path));

    if (start) await controller.play();
  }

  /// tested
  Future<void> closeVideoPlayer() async {
    if (controller.value.isPlaying) {
      await controller.pause();
    }
  }

  /// tested
  void closeControllers() {
    closePlayer();
    closeVideoPlayer();
  }

  /// tested
  Future<void> pause() async {
    await controller.pause();
    closePlayer();
  }

  Future<File?> createThumbnail(String path) async {
    final String? uint8list = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      maxHeight:
          230, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );

    if (uint8list != null) {
      return File(uint8list);
    }
    return null;
  }
}
