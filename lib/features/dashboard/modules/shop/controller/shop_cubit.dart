import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/repo/shop_repo.dart';

part 'shop_state.dart';

class ShopCubit extends BaseCubit<ShopState> {
  ShopCubit() : super(ShopInitial()) {
    onInit();
  }

  int? pageValue;
  ShopModel shops = ShopModel();

  String query = '';
  TextEditingController searchBarController = TextEditingController();
  void resetSearchBar(){
    searchBarController.clear();
    query="";
    emit(ResetSearchbar());
  }
  Future<void> onInit() async {
    emit(ShopLoading());
    pageValue = 0;
    (await sl<ShopRepo>().getShops())
        .fold((Failure l) => emit(ShopFailure(l.errors.values.toString())), (ParentModel r) {
      shops = r as ShopModel;
      shops.shopCategories?.insert(0,ShopCategories(uuid: '',name: tr('all_categories'))
        ..isSelect=true);
      emit(ShopLoaded());
    });
  }

  void onChangeImage(int value) {
    pageValue = value;
    emit(ImageChangeUpdated());
  }

  List<Shops> get categoryFilteredList {
    List<Shops> shopsList = <Shops>[];

    ///unselect category
    if (!shops.shopCategories!.any((ShopCategories element) => element.isSelect)) {
      shopsList = shops.shops ?? <Shops>[];
    }
    else if (shops.shopCategories!.firstWhere((ShopCategories element) => element.isSelect).name==tr('all_categories')) {
      shopsList = shops.shops ?? <Shops>[];
    }
    else {
      final String selectedCategoryUUID =
          shops.shopCategories!.firstWhere((ShopCategories element) => element.isSelect).uuid!;
      shopsList = shops.shops
              ?.where((Shops element) => element.shopCategoryUuid == selectedCategoryUUID)
              .toList() ??
          <Shops>[];
    }
    if (query.isEmpty) {
      return shopsList;
    } else {
      return shopsList
          .where((Shops element) => (element.name ?? '').contains(query.toLowerCase()))
          .toList();
    }
  }

  ///change category
  void changeCategory(int index) {
    for (final ShopCategories f in shops.shopCategories ?? <ShopCategories>[]) {
      f.isSelect = false;
    }
    shops.shopCategories![index].isSelect = !shops.shopCategories![index].isSelect;
    emit(CategoryFilterChanged(index));
  }

  void onChangeSearch(String value) {
    query = value;
    emit(ShopLoaded());
  }

  @override
  Future<void> onRefresh() async{
    await onInit();
  }
}
