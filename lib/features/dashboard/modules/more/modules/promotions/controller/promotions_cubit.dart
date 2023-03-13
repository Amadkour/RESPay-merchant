import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/repo/promotions_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';

part 'promotions_state.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsRepo? promotionsRepo;

  List<SinglePromotion> filteredPromotions = <SinglePromotion>[];
  void filter(String value){
    if(promotionsModel!=null){
      if(value==""){
        filteredPromotions = promotionsModel!.promotions!.cast<SinglePromotion>();
      }
      else{
        filteredPromotions= promotionsModel!.promotions!.where((ParentModel element) =>
        (element as SinglePromotion).shopName!.contains(value) || element.shopName!.contains(value.toLowerCase())).toList().cast<SinglePromotion>();
      }
    }
    else{
      filteredPromotions=  <SinglePromotion>[];
    }
    emit(PromotionsInitial());
  }
  TextEditingController searchBarController = TextEditingController();
  void resetSearchBar(){
    searchBarController.clear();
    filteredPromotions = promotionsModel!.promotions!.cast<SinglePromotion>();
    emit(ResetSearchbar());
  }
  PromotionsCubit(this.promotionsRepo) : super(PromotionsInitial());
  List<FilterItem> filters =<FilterItem>[
    FilterItem(
        options: <String>[
          'all_product','popular','latest',"lowest_price","highest_price"
        ],
        currentValue: 'all_product'
    ),
    FilterItem(
        options:<String>[
          "latest","lowest_price","highest_price"
        ],
        currentValue: "latest"
    ),
  ];
  PromotionsModel ?promotionsModel;
  Future<void>getPromotions()async{
   try{
     if(promotionsModel!=null){
       emit(PromotionsLoaded());
     }
     else{
       emit(PromotionsLoading());
       final Either<Failure, ParentModel> result =await promotionsRepo!.getPromotions();
       result.fold((Failure l) {
         emit(PromotionsError());
       }, (ParentModel r) {
         promotionsModel=r as PromotionsModel;
         emit(PromotionsLoaded());
       });
     }
   }catch(e){
     emit(PromotionsError());
   }
  }

  void resetState(){
    emit(PromotionsInitial());
  }
}
