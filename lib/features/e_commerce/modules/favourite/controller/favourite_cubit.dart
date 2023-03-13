import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/repo/remote_favourite_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

part 'favourite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.remoteFavoriteRepo) : super(FavoriteInitial());
  bool buildWhenCondition(dynamic productModel) {
    if (productModel is ProductModel) {
      return currentProduct == productModel.id! || currentProduct == "";
    }
    if (productModel is FavoriteItemModel) {
      return currentProduct == productModel.uuid! || currentProduct == "";
    }
    return true;
  }

  void resetFavorite() {
    favoritesModel = null;
  }

  String? currentProduct = "";
  RemoteFavoriteRepo? remoteFavoriteRepo;

  FavoritesModel? favoritesModel;
  void setCurrentProduct(String newValue) {
    currentProduct = newValue;
    emit(FavoriteInitial());
  }

  bool isInFav(ProductModel productModel) {
    if (favoritesModel != null) {
      return favoritesModel!.favorites!.items!
          .where((FavoriteItemModel element) => element.uuid == productModel.id)
          .isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> addToFavorite(ProductModel productModel) async {
    emit(FavoriteCubitItemUpdateStateLoading());
    (await remoteFavoriteRepo!.addProductToFavorite(productModel.id!))
        .fold((Failure l) {}, (ParentModel r) async {
      getFavorites(showLoading: false);
    });
  }

  Future<void> removeFromFavorite(String productId) async {
    emit(FavoriteCubitItemUpdateStateLoading());
    (await remoteFavoriteRepo!.deleteProductFromFavorite(
            favoritesModel!.favorites!.uuid!, productId))
        .fold((Failure l) {}, (ParentModel r) {
      getFavorites(showLoading: false);
    });
  }

  Future<void> getFavorites({bool showLoading = true}) async {
    if (showLoading) {
      emit(FavoritesLoading());
    }
    (await remoteFavoriteRepo!.getFavoriteProducts()).fold((Failure l) {
      favoritesModel =
          FavoritesModel(favorites: Favorites(items: <FavoriteItemModel>[]));
      emit(FavoritesError());
    }, (ParentModel r) async {
      favoritesModel = r as FavoritesModel;
      currentProduct = "";
      emit(FavoritesLoaded());
    });
  }
}
