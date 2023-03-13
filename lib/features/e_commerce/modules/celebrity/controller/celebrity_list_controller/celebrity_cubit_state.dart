
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';

abstract class CelebrityState {
  const CelebrityState();
}

class CelebrityInitial extends CelebrityState {}

class SearchBarResetState extends CelebrityState {}

class CelebrityLoading extends CelebrityState {}

class CelebrityLoaded extends CelebrityState {}

class VideoListLoaded extends CelebrityState {}

class CelebrityFailure extends CelebrityState {
  final Failure failure;

  const CelebrityFailure(this.failure);
}

class CelebrityGenderFilterChanged extends CelebrityState {
  final CelebrityGender gender;

  const CelebrityGenderFilterChanged(this.gender);
}

class CelebritySearched extends CelebrityState {
  final String query;

  const CelebritySearched(this.query);
}

class CelebrityVideoLoaded extends CelebrityState {
  final String path;

  const CelebrityVideoLoaded(this.path);
}
class CelebrityDetailInitial extends CelebrityState {}
class ProductsFilterChanged extends CelebrityState {}
class OffersLoaded extends CelebrityState {}
class CelebrityDetailLoading extends CelebrityState {}
class CelebrityDetailErrorState extends CelebrityState {}
class CelebrityDetailLoadedState extends CelebrityState {}
