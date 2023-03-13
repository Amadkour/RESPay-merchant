import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/model/category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/repos/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial()) {
    get();
  }
  List<CategoryModel> categories = <CategoryModel>[];

  final CategoryRepo _repo = sl<CategoryRepo>();

  Future<List<CategoryModel>> get() async {
    emit(CategoryLoading());
    final Either<Failure, List<CategoryModel>> result = await _repo.get();
    return result.fold((Failure l) {
      emit(CategoryError(l));
      return <CategoryModel>[];
    }, (List<CategoryModel> r) {
      categories = r;
      categories.add(CategoryModel(
        id: 5,
        name: "new one",
        icon: "assets/icons/category/other.svg",
        color: "#4EC89E".toColor(),
      ));
      emit(CategoryLoaded());
      return r;
    });
  }
}
