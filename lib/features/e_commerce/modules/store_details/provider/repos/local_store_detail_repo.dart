import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/repos/store_detail_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/offer_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';


class LocalStoreDetailRepo extends StoreDetailRepo {
  LocalStoreDetailRepo();
  @override
  Future<List<ParentModel>> getOffers() async {
    final String response = await rootBundle.loadString('assets/jsons/e_commerce/offers.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic> ;
    return data.map((dynamic e) => OfferModel().fromJsonInstance(e as Map<String,dynamic>)).toList();
  }

  @override
  Future<List<ProductModel>> getHotDeals() async{
    final String response = await rootBundle.loadString('assets/jsons/e_commerce/hotDeals.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic> ;
    return data.map((dynamic e) => ProductModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  @override
  Future<Either<Failure, ParentModel>> getSingleShop(String slug) {
    // TODO: implement getSingleShop
    throw UnimplementedError();
  }

}
