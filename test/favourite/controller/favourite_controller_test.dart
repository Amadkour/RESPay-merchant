import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_product_added_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_product_removed_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/repo/remote_favourite_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

import 'favourite_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  RemoteFavoriteRepo,
])
void main() {
  group('Favourite Cubit test', () {
    late MockRemoteFavoriteRepo mockRemoteFavoriteRepo;
    setUpAll(() {
      mockRemoteFavoriteRepo = MockRemoteFavoriteRepo();
      when(mockRemoteFavoriteRepo.getFavoriteProducts()).thenAnswer(
          (Invocation realInvocation) async =>
              Right<Failure, ParentModel>(FavoritesModel()));
    });

    blocTest<FavoriteCubit, FavoriteState>(
      'getFavourites method',
      build: () {
        when(mockRemoteFavoriteRepo.getFavoriteProducts()).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(FavoritesModel()));

        return FavoriteCubit(mockRemoteFavoriteRepo);
      },
      act: (FavoriteCubit bloc) async {
        await bloc.getFavorites();
      },
      expect: () => <TypeMatcher<FavoriteState>>[
        isA<FavoritesLoading>(),
        isA<FavoritesLoaded>(),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'addToFavourite method',
      build: () {
        when(mockRemoteFavoriteRepo.addProductToFavorite("adsdsdasd43243"))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, ParentModel>(FavouriteProductAddedModel()));

        return FavoriteCubit(mockRemoteFavoriteRepo);
      },
      act: (FavoriteCubit bloc) async {
        await bloc.addToFavorite(ProductModel(id: "adsdsdasd43243"));
      },
      expect: () => <TypeMatcher<FavoriteState>>[
        isA<FavoriteCubitItemUpdateStateLoading>(),
        isA<FavoritesLoaded>(),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'removeFromFavourite method',
      build: () {
        when(mockRemoteFavoriteRepo.deleteProductFromFavorite(
                "85d59540-bbd4-32b8-b4b2-dd969e6a0fd3", "85d59540-bbd4-32b8"))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, ParentModel>(FavouriteProductRemovedModel()));

        return FavoriteCubit(mockRemoteFavoriteRepo);
      },
      act: (FavoriteCubit bloc) async {
        bloc.favoritesModel = FavoritesModel(
            favorites: Favorites(
                uuid: "85d59540-bbd4-32b8-b4b2-dd969e6a0fd3",
                items: <FavoriteItemModel>[
              FavoriteItemModel(
                description: "test",
                name: "test",
                uuid: "32432csdff",
              )
            ]));
        await bloc.removeFromFavorite("85d59540-bbd4-32b8");
      },
      expect: () => <TypeMatcher<FavoriteState>>[
        isA<FavoriteCubitItemUpdateStateLoading>(),
        isA<FavoritesLoaded>(),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'verify that isInFav method return true',
      build: () => FavoriteCubit(mockRemoteFavoriteRepo),
      act: (FavoriteCubit bloc) {
        bloc.favoritesModel = FavoritesModel(
            favorites: Favorites(items: <FavoriteItemModel>[
          FavoriteItemModel(
            description: "test",
            name: "test",
            uuid: "42343fsdfd34",
          )
        ]));
        bloc.isInFav(ProductModel(id: "42343fsdfd34"));
      },
      expect: () => <TypeMatcher<FavoriteState>>[],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'verify that setCurrentProduct is done',
      build: () => FavoriteCubit(mockRemoteFavoriteRepo),
      act: (FavoriteCubit bloc) {
        bloc.setCurrentProduct("dqwdwq");
      },
      expect: () => <TypeMatcher<FavoriteState>>[
        isA<FavoriteInitial>(),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'verify that resetFavorite method return true',
      build: () => FavoriteCubit(mockRemoteFavoriteRepo),
      act: (FavoriteCubit bloc) {
        bloc.resetFavorite();
      },
      expect: () => <TypeMatcher<FavoriteState>>[],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'verify that buildWhenCondition method return true',
      build: () => FavoriteCubit(mockRemoteFavoriteRepo),
      act: (FavoriteCubit bloc) {
        bloc.buildWhenCondition(ProductModel(id: "Asdasda"));
      },
      expect: () => <TypeMatcher<FavoriteState>>[],
    );
  });
}
