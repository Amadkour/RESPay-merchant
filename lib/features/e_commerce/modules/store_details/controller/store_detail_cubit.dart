import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/models/shop_product_category_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/models/single_shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/repos/remote_store_detail_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  RemoteStoreDetailRepo? remoteEcommerceRepo;
  StoreDetailCubit(this.remoteEcommerceRepo) : super(StoreDetailInitial());
  List<ProductModel>?hotDeals;

  Future<void> getHotDeals() async{
    hotDeals  = await remoteEcommerceRepo!.getHotDeals();
  }
  List<FilterItem> storeDetailFilters =<FilterItem>[];
  Shops ?shop;

  TextEditingController searchBarController = TextEditingController();
  void filterByName(String name) {
    // if(state is! SingleShopFailure && state is! ShopLoading){
    //   emit(ProductsFiltered());
    // }
    emit(ProductsFiltered());
  }

  void convertListToFilterItem(List<ShopProductCategoryModel>categories){
    storeDetailFilters=<FilterItem>[];
    categories.forEach((ShopProductCategoryModel element) {
      storeDetailFilters.add(FilterItem(
        options: <String>[element.name ?? ''],
        currentValue: "",
      ));
    });
  }

  bool isNameContainsSearchBarText(ProductModel productModel) {
    return productModel.name.contains(searchBarController.text.toLowerCase()) ||
        productModel.name.contains(searchBarController.text.toUpperCase());
  }


  List<ProductModel> getCorrectList(FilterItem currentFilter) {
    final List<ProductModel>filteredList=<ProductModel>[];
    if(currentFilter.currentValue==""){
      return shop!.products!.where((ProductModel element) => element.name.contains(searchBarController.text)).toList();
    }
    else{
      if(shop!.products!=null){
        if(currentFilter.currentValue==""){
          return shop!.products!;
        }
        else{
          for(int currentProductIndex =0;currentProductIndex< shop!.products!.length;currentProductIndex++){
            for(int currentCategoryIndex=0;currentCategoryIndex<shop!.products![currentProductIndex].categories!.length;currentCategoryIndex++){
              if(shop!.products![currentProductIndex].categories![currentCategoryIndex].name
                  == currentFilter.currentValue&&shop!.products![currentProductIndex].name.contains(searchBarController.text)){
                filteredList.add(shop!.products![currentProductIndex]);
              }
            }
          }
        }
        return filteredList;
      }
      else{
        return <ProductModel>[];
      }
    }
  }

  void resetSearchBar(){
    searchBarController.clear();
  }
  String ?currentShopUUID;
  Future<String?> getSingleShop({required String slug}) async {

    emit(ShopLoading());

   try{
     await getHotDeals();
     (await remoteEcommerceRepo!.getSingleShop(slug))
         .fold((Failure l) => emit(SingleShopFailure(l.errors.values.toString())), (ParentModel r) {
       shop = (r as SingleShopModel).shop;
       currentShopUUID=shop!.uuid;
       if (shop!.categories != null && shop!.categories!.isNotEmpty) {
         convertListToFilterItem(shop!.categories!);
       }
       emit(SingleShopLoaded(shop!));
     });
   }catch(x){
     MyToast("error happen");
     emit(SingleShopFailure("error happen"));
   }
   return currentShopUUID;
  }
}
