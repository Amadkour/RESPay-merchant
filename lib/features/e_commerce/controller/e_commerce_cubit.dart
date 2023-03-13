import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';

part 'e_commerce_state.dart';

class ECommerceCubit extends Cubit<ECommerceState> {

  ECommerceCubit() : super(ECommerceInitial());

  FilterItem currentFilterItem =FilterItem(options: <String>[""],currentValue: "");
  void setCurrentValueToFilterOption(FilterItem filterItem, {String ?currentValue}){
    if(filterItem.options!.length==1){
      if(tr(currentFilterItem.currentValue!)==currentValue){
        currentFilterItem.currentValue="";
      }
      else{
        currentFilterItem.currentValue=filterItem.options!.first;
      }
    }
    emit(ProductsFilterChanged());
  }

  void resetFilterValues(){
    celebrityFilters.forEach((FilterItem element) {
      element.currentValue=element.options!.first;
    });
    currentFilterItem.currentValue="";
  }
  List<FilterItem> celebrityFilters =<FilterItem>[
    FilterItem(
      options: <String>[
        'all_product','popular','latest',"lowest_price","highest_price"
      ],
      currentValue: tr("all_product")
    ),
    FilterItem(
        options:<String>[
          "latest","lowest_price","highest_price"
        ],
        currentValue: tr("latest")
    ),
  ];
}
