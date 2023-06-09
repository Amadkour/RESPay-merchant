// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/features/e_commerce/modules/celebrity/controller/celebrity_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i13;

import 'package:audio_session/audio_session.dart' as _i10;
import 'package:dartz/dartz.dart' as _i2;
import 'package:just_audio/just_audio.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i7;
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart' as _i8;
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/video_shop.dart'
    as _i9;
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/repo/remote_celebrity_list_repo.dart'
    as _i5;
import 'package:video_player/src/closed_caption_file.dart' as _i12;
import 'package:video_player/video_player.dart' as _i4;
import 'package:video_player_platform_interface/video_player_platform_interface.dart'
    as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlaybackEvent_1 extends _i1.SmartFake implements _i3.PlaybackEvent {
  _FakePlaybackEvent_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_2 extends _i1.SmartFake implements Duration {
  _FakeDuration_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlayerState_3 extends _i1.SmartFake implements _i3.PlayerState {
  _FakePlayerState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVideoPlayerValue_4 extends _i1.SmartFake
    implements _i4.VideoPlayerValue {
  _FakeVideoPlayerValue_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CelebrityRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockCelebrityRepo extends _i1.Mock implements _i5.CelebrityRepo {
  MockCelebrityRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>> getAllCelebrities() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllCelebrities,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>>.value(
            _FakeEither_0<_i7.Failure, _i8.ParentModel>(
          this,
          Invocation.method(
            #getAllCelebrities,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>> getSingleCelebrityData(
          {required String? celebrityUuid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSingleCelebrityData,
          [],
          {#celebrityUuid: celebrityUuid},
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>>.value(
            _FakeEither_0<_i7.Failure, _i8.ParentModel>(
          this,
          Invocation.method(
            #getSingleCelebrityData,
            [],
            {#celebrityUuid: celebrityUuid},
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.ParentModel>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>> getVideos() =>
      (super.noSuchMethod(
        Invocation.method(
          #getVideos,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>>.value(
            _FakeEither_0<_i7.Failure, List<_i9.Story>>(
          this,
          Invocation.method(
            #getVideos,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>>);
}

/// A class which mocks [AudioPlayer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAudioPlayer extends _i1.Mock implements _i3.AudioPlayer {
  MockAudioPlayer() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PlaybackEvent get playbackEvent => (super.noSuchMethod(
        Invocation.getter(#playbackEvent),
        returnValue: _FakePlaybackEvent_1(
          this,
          Invocation.getter(#playbackEvent),
        ),
      ) as _i3.PlaybackEvent);
  @override
  _i6.Stream<_i3.PlaybackEvent> get playbackEventStream => (super.noSuchMethod(
        Invocation.getter(#playbackEventStream),
        returnValue: _i6.Stream<_i3.PlaybackEvent>.empty(),
      ) as _i6.Stream<_i3.PlaybackEvent>);
  @override
  _i6.Stream<Duration?> get durationStream => (super.noSuchMethod(
        Invocation.getter(#durationStream),
        returnValue: _i6.Stream<Duration?>.empty(),
      ) as _i6.Stream<Duration?>);
  @override
  _i3.ProcessingState get processingState => (super.noSuchMethod(
        Invocation.getter(#processingState),
        returnValue: _i3.ProcessingState.idle,
      ) as _i3.ProcessingState);
  @override
  _i6.Stream<_i3.ProcessingState> get processingStateStream =>
      (super.noSuchMethod(
        Invocation.getter(#processingStateStream),
        returnValue: _i6.Stream<_i3.ProcessingState>.empty(),
      ) as _i6.Stream<_i3.ProcessingState>);
  @override
  bool get playing => (super.noSuchMethod(
        Invocation.getter(#playing),
        returnValue: false,
      ) as bool);
  @override
  _i6.Stream<bool> get playingStream => (super.noSuchMethod(
        Invocation.getter(#playingStream),
        returnValue: _i6.Stream<bool>.empty(),
      ) as _i6.Stream<bool>);
  @override
  double get volume => (super.noSuchMethod(
        Invocation.getter(#volume),
        returnValue: 0.0,
      ) as double);
  @override
  _i6.Stream<double> get volumeStream => (super.noSuchMethod(
        Invocation.getter(#volumeStream),
        returnValue: _i6.Stream<double>.empty(),
      ) as _i6.Stream<double>);
  @override
  double get speed => (super.noSuchMethod(
        Invocation.getter(#speed),
        returnValue: 0.0,
      ) as double);
  @override
  _i6.Stream<double> get speedStream => (super.noSuchMethod(
        Invocation.getter(#speedStream),
        returnValue: _i6.Stream<double>.empty(),
      ) as _i6.Stream<double>);
  @override
  double get pitch => (super.noSuchMethod(
        Invocation.getter(#pitch),
        returnValue: 0.0,
      ) as double);
  @override
  _i6.Stream<double> get pitchStream => (super.noSuchMethod(
        Invocation.getter(#pitchStream),
        returnValue: _i6.Stream<double>.empty(),
      ) as _i6.Stream<double>);
  @override
  bool get skipSilenceEnabled => (super.noSuchMethod(
        Invocation.getter(#skipSilenceEnabled),
        returnValue: false,
      ) as bool);
  @override
  _i6.Stream<bool> get skipSilenceEnabledStream => (super.noSuchMethod(
        Invocation.getter(#skipSilenceEnabledStream),
        returnValue: _i6.Stream<bool>.empty(),
      ) as _i6.Stream<bool>);
  @override
  Duration get bufferedPosition => (super.noSuchMethod(
        Invocation.getter(#bufferedPosition),
        returnValue: _FakeDuration_2(
          this,
          Invocation.getter(#bufferedPosition),
        ),
      ) as Duration);
  @override
  _i6.Stream<Duration> get bufferedPositionStream => (super.noSuchMethod(
        Invocation.getter(#bufferedPositionStream),
        returnValue: _i6.Stream<Duration>.empty(),
      ) as _i6.Stream<Duration>);
  @override
  _i6.Stream<_i3.IcyMetadata?> get icyMetadataStream => (super.noSuchMethod(
        Invocation.getter(#icyMetadataStream),
        returnValue: _i6.Stream<_i3.IcyMetadata?>.empty(),
      ) as _i6.Stream<_i3.IcyMetadata?>);
  @override
  _i3.PlayerState get playerState => (super.noSuchMethod(
        Invocation.getter(#playerState),
        returnValue: _FakePlayerState_3(
          this,
          Invocation.getter(#playerState),
        ),
      ) as _i3.PlayerState);
  @override
  _i6.Stream<_i3.PlayerState> get playerStateStream => (super.noSuchMethod(
        Invocation.getter(#playerStateStream),
        returnValue: _i6.Stream<_i3.PlayerState>.empty(),
      ) as _i6.Stream<_i3.PlayerState>);
  @override
  _i6.Stream<List<_i3.IndexedAudioSource>?> get sequenceStream =>
      (super.noSuchMethod(
        Invocation.getter(#sequenceStream),
        returnValue: _i6.Stream<List<_i3.IndexedAudioSource>?>.empty(),
      ) as _i6.Stream<List<_i3.IndexedAudioSource>?>);
  @override
  _i6.Stream<List<int>?> get shuffleIndicesStream => (super.noSuchMethod(
        Invocation.getter(#shuffleIndicesStream),
        returnValue: _i6.Stream<List<int>?>.empty(),
      ) as _i6.Stream<List<int>?>);
  @override
  _i6.Stream<int?> get currentIndexStream => (super.noSuchMethod(
        Invocation.getter(#currentIndexStream),
        returnValue: _i6.Stream<int?>.empty(),
      ) as _i6.Stream<int?>);
  @override
  _i6.Stream<_i3.SequenceState?> get sequenceStateStream => (super.noSuchMethod(
        Invocation.getter(#sequenceStateStream),
        returnValue: _i6.Stream<_i3.SequenceState?>.empty(),
      ) as _i6.Stream<_i3.SequenceState?>);
  @override
  bool get hasNext => (super.noSuchMethod(
        Invocation.getter(#hasNext),
        returnValue: false,
      ) as bool);
  @override
  bool get hasPrevious => (super.noSuchMethod(
        Invocation.getter(#hasPrevious),
        returnValue: false,
      ) as bool);
  @override
  _i3.LoopMode get loopMode => (super.noSuchMethod(
        Invocation.getter(#loopMode),
        returnValue: _i3.LoopMode.off,
      ) as _i3.LoopMode);
  @override
  _i6.Stream<_i3.LoopMode> get loopModeStream => (super.noSuchMethod(
        Invocation.getter(#loopModeStream),
        returnValue: _i6.Stream<_i3.LoopMode>.empty(),
      ) as _i6.Stream<_i3.LoopMode>);
  @override
  bool get shuffleModeEnabled => (super.noSuchMethod(
        Invocation.getter(#shuffleModeEnabled),
        returnValue: false,
      ) as bool);
  @override
  _i6.Stream<bool> get shuffleModeEnabledStream => (super.noSuchMethod(
        Invocation.getter(#shuffleModeEnabledStream),
        returnValue: _i6.Stream<bool>.empty(),
      ) as _i6.Stream<bool>);
  @override
  _i6.Stream<int?> get androidAudioSessionIdStream => (super.noSuchMethod(
        Invocation.getter(#androidAudioSessionIdStream),
        returnValue: _i6.Stream<int?>.empty(),
      ) as _i6.Stream<int?>);
  @override
  _i6.Stream<_i3.PositionDiscontinuity> get positionDiscontinuityStream =>
      (super.noSuchMethod(
        Invocation.getter(#positionDiscontinuityStream),
        returnValue: _i6.Stream<_i3.PositionDiscontinuity>.empty(),
      ) as _i6.Stream<_i3.PositionDiscontinuity>);
  @override
  bool get automaticallyWaitsToMinimizeStalling => (super.noSuchMethod(
        Invocation.getter(#automaticallyWaitsToMinimizeStalling),
        returnValue: false,
      ) as bool);
  @override
  bool get canUseNetworkResourcesForLiveStreamingWhilePaused =>
      (super.noSuchMethod(
        Invocation.getter(#canUseNetworkResourcesForLiveStreamingWhilePaused),
        returnValue: false,
      ) as bool);
  @override
  double get preferredPeakBitRate => (super.noSuchMethod(
        Invocation.getter(#preferredPeakBitRate),
        returnValue: 0.0,
      ) as double);
  @override
  Duration get position => (super.noSuchMethod(
        Invocation.getter(#position),
        returnValue: _FakeDuration_2(
          this,
          Invocation.getter(#position),
        ),
      ) as Duration);
  @override
  _i6.Stream<Duration> get positionStream => (super.noSuchMethod(
        Invocation.getter(#positionStream),
        returnValue: _i6.Stream<Duration>.empty(),
      ) as _i6.Stream<Duration>);
  @override
  _i6.Stream<Duration> createPositionStream({
    int? steps = 800,
    Duration? minPeriod = const Duration(milliseconds: 200),
    Duration? maxPeriod = const Duration(milliseconds: 200),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPositionStream,
          [],
          {
            #steps: steps,
            #minPeriod: minPeriod,
            #maxPeriod: maxPeriod,
          },
        ),
        returnValue: _i6.Stream<Duration>.empty(),
      ) as _i6.Stream<Duration>);
  @override
  _i6.Future<Duration?> setUrl(
    String? url, {
    Map<String, String>? headers,
    Duration? initialPosition,
    bool? preload = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUrl,
          [url],
          {
            #headers: headers,
            #initialPosition: initialPosition,
            #preload: preload,
          },
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<Duration?> setFilePath(
    String? filePath, {
    Duration? initialPosition,
    bool? preload = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFilePath,
          [filePath],
          {
            #initialPosition: initialPosition,
            #preload: preload,
          },
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<Duration?> setAsset(
    String? assetPath, {
    String? package,
    bool? preload = true,
    Duration? initialPosition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAsset,
          [assetPath],
          {
            #package: package,
            #preload: preload,
            #initialPosition: initialPosition,
          },
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<Duration?> setAudioSource(
    _i3.AudioSource? source, {
    bool? preload = true,
    int? initialIndex,
    Duration? initialPosition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAudioSource,
          [source],
          {
            #preload: preload,
            #initialIndex: initialIndex,
            #initialPosition: initialPosition,
          },
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<Duration?> load() => (super.noSuchMethod(
        Invocation.method(
          #load,
          [],
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<Duration?> setClip({
    Duration? start,
    Duration? end,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setClip,
          [],
          {
            #start: start,
            #end: end,
          },
        ),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i6.Future<void> play() => (super.noSuchMethod(
        Invocation.method(
          #play,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> pause() => (super.noSuchMethod(
        Invocation.method(
          #pause,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> stop() => (super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setVolume(double? volume) => (super.noSuchMethod(
        Invocation.method(
          #setVolume,
          [volume],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setSkipSilenceEnabled(bool? enabled) => (super.noSuchMethod(
        Invocation.method(
          #setSkipSilenceEnabled,
          [enabled],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setSpeed(double? speed) => (super.noSuchMethod(
        Invocation.method(
          #setSpeed,
          [speed],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setPitch(double? pitch) => (super.noSuchMethod(
        Invocation.method(
          #setPitch,
          [pitch],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setLoopMode(_i3.LoopMode? mode) => (super.noSuchMethod(
        Invocation.method(
          #setLoopMode,
          [mode],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setShuffleModeEnabled(bool? enabled) => (super.noSuchMethod(
        Invocation.method(
          #setShuffleModeEnabled,
          [enabled],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> shuffle() => (super.noSuchMethod(
        Invocation.method(
          #shuffle,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setAutomaticallyWaitsToMinimizeStalling(
          bool? automaticallyWaitsToMinimizeStalling) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAutomaticallyWaitsToMinimizeStalling,
          [automaticallyWaitsToMinimizeStalling],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setCanUseNetworkResourcesForLiveStreamingWhilePaused(
          bool? canUseNetworkResourcesForLiveStreamingWhilePaused) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCanUseNetworkResourcesForLiveStreamingWhilePaused,
          [canUseNetworkResourcesForLiveStreamingWhilePaused],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setPreferredPeakBitRate(double? preferredPeakBitRate) =>
      (super.noSuchMethod(
        Invocation.method(
          #setPreferredPeakBitRate,
          [preferredPeakBitRate],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> seek(
    Duration? position, {
    int? index,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #seek,
          [position],
          {#index: index},
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> seekToNext() => (super.noSuchMethod(
        Invocation.method(
          #seekToNext,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> seekToPrevious() => (super.noSuchMethod(
        Invocation.method(
          #seekToPrevious,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setAndroidAudioAttributes(
          _i10.AndroidAudioAttributes? audioAttributes) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAndroidAudioAttributes,
          [audioAttributes],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [VideoPlayerController].
///
/// See the documentation for Mockito's code generation for more information.
class MockVideoPlayerController extends _i1.Mock
    implements _i4.VideoPlayerController {
  MockVideoPlayerController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get dataSource => (super.noSuchMethod(
        Invocation.getter(#dataSource),
        returnValue: '',
      ) as String);
  @override
  Map<String, String> get httpHeaders => (super.noSuchMethod(
        Invocation.getter(#httpHeaders),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  _i11.DataSourceType get dataSourceType => (super.noSuchMethod(
        Invocation.getter(#dataSourceType),
        returnValue: _i11.DataSourceType.asset,
      ) as _i11.DataSourceType);
  @override
  int get textureId => (super.noSuchMethod(
        Invocation.getter(#textureId),
        returnValue: 0,
      ) as int);
  @override
  _i6.Future<Duration?> get position => (super.noSuchMethod(
        Invocation.getter(#position),
        returnValue: _i6.Future<Duration?>.value(),
      ) as _i6.Future<Duration?>);
  @override
  _i4.VideoPlayerValue get value => (super.noSuchMethod(
        Invocation.getter(#value),
        returnValue: _FakeVideoPlayerValue_4(
          this,
          Invocation.getter(#value),
        ),
      ) as _i4.VideoPlayerValue);
  @override
  set value(_i4.VideoPlayerValue? newValue) => super.noSuchMethod(
        Invocation.setter(
          #value,
          newValue,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> initialize() => (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> play() => (super.noSuchMethod(
        Invocation.method(
          #play,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setLooping(bool? looping) => (super.noSuchMethod(
        Invocation.method(
          #setLooping,
          [looping],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> pause() => (super.noSuchMethod(
        Invocation.method(
          #pause,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> seekTo(Duration? position) => (super.noSuchMethod(
        Invocation.method(
          #seekTo,
          [position],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setVolume(double? volume) => (super.noSuchMethod(
        Invocation.method(
          #setVolume,
          [volume],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> setPlaybackSpeed(double? speed) => (super.noSuchMethod(
        Invocation.method(
          #setPlaybackSpeed,
          [speed],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void setCaptionOffset(Duration? offset) => super.noSuchMethod(
        Invocation.method(
          #setCaptionOffset,
          [offset],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<void> setClosedCaptionFile(
          _i6.Future<_i12.ClosedCaptionFile>? closedCaptionFile) =>
      (super.noSuchMethod(
        Invocation.method(
          #setClosedCaptionFile,
          [closedCaptionFile],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void removeListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
