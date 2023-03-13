import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/controller/store_detail_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/models/shop_product_category_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/models/single_shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/repos/remote_store_detail_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

import 'store_details_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  RemoteStoreDetailRepo
])
void main() {
  late MockRemoteStoreDetailRepo repository;

  setUpAll(() {
    repository = MockRemoteStoreDetailRepo();
  });

  group('test group StoreDetailCubit', () {
    ///--------filterByName method testing------///
    blocTest<StoreDetailCubit, StoreDetailState>(
      'verify that filterByName method return success',
      build: () => StoreDetailCubit(repository),
      act: (StoreDetailCubit bloc) => bloc.filterByName("test"),
      expect: () => <TypeMatcher<StoreDetailState>>[
        isA<ProductsFiltered>()
      ],
    );
    blocTest<StoreDetailCubit, StoreDetailState>(
      'verify that convertListToFilterItem method return success',
      build: () => StoreDetailCubit(repository),
      act: (StoreDetailCubit bloc) => bloc.convertListToFilterItem(<ShopProductCategoryModel>[ShopProductCategoryModel(id: 1,name: "test 1",uuid: "3431fsdfs")]),
      expect: () => <TypeMatcher<StoreDetailState>>[],
    );

    blocTest<StoreDetailCubit, StoreDetailState>(
      'verify that isNameContainsSearchBarText method return success',
      build: () => StoreDetailCubit(repository),
      act: (StoreDetailCubit bloc) => bloc.isNameContainsSearchBarText(ProductModel(name: "test 1")),
      expect: () => <TypeMatcher<StoreDetailState>>[],
    );

    blocTest<StoreDetailCubit, StoreDetailState>(
      'verify that resetSearchBar method return success',
      build: () => StoreDetailCubit(repository),
      act: (StoreDetailCubit bloc) => bloc.resetSearchBar(),
      expect: () => <TypeMatcher<StoreDetailState>>[],
    );

    blocTest<StoreDetailCubit, StoreDetailState>(
      'verify that getCorrectList method return success',
      build: () => StoreDetailCubit(repository),
      act: (StoreDetailCubit bloc) {
        bloc.shop=Shops(products: <ProductModel>[ProductModel(name: "product 1",id: "sdsae23"
            ,categories: <ProductCategory>[ProductCategory(id: 1,name: "category 1",uuid: "4324fsdfs")])]);
        return bloc.getCorrectList(FilterItem(options:<String> [
          "category 1"
        ],currentValue: ""));
      },
      expect: () => <TypeMatcher<StoreDetailState>>[],
    );

    blocTest<StoreDetailCubit, StoreDetailState>(
      'onFail Test addNewGiftBeneficiary',
      build: () {
        when(repository.getSingleShop("testSlug")).thenAnswer(
                (Invocation realInvocation) async => Right<Failure, ParentModel>(SingleShopModel(shop: Shops(products: <ProductModel>[]))));

        return StoreDetailCubit(repository);
      },
      act: (StoreDetailCubit bloc) {
        bloc.getSingleShop(slug: "testSlug");
      },
      expect: () => <TypeMatcher<StoreDetailState>>[
        isA<ShopLoading>(),
        isA<SingleShopLoaded>(),

      ],
    );

  });
}
