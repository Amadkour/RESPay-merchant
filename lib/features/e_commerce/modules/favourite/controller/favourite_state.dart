part of 'favourite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class AddToFavourite extends FavoriteState {}

class RemoveFromFavourite extends FavoriteState {}

class FavoritesLoading extends FavoriteState {}

class FavoriteCubitItemUpdateStateLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {}

class ItemAdditionInFavouriteLoading extends FavoriteState {}

class FavoritesError extends FavoriteState {}
