import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/components/promotions_list_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/components/single_promotion_item.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/list_of_product_filters.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/product_filter_item.dart';

import 'promotions_page_test.mocks.dart';


@GenerateMocks(<Type>[PromotionsCubit])
void main() {
  late MockPromotionsCubit mockPromotionsCubit;

  late final List<FilterItem> filters =<FilterItem>[
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
  setUp(() {
    mockPromotionsCubit = MockPromotionsCubit();
  });
  group('testing promotions screen', () {
    testWidgets('testing promotions view', (WidgetTester tester) async {
      when(mockPromotionsCubit.promotionsModel).thenReturn(PromotionsModel(
        promotions: <SinglePromotion>[SinglePromotion(validTo: "ds",shopName: "sdasd",offerCount: 2,value: "test")]
      ));
      when(mockPromotionsCubit.filters).thenReturn(<FilterItem>[
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
      ]);
      await tester.pumpWidget(BlocProvider<PromotionsCubit>(
        create: (BuildContext context) => mockPromotionsCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: ListOfPromotions(
                filteredPromotions:mockPromotionsCubit.promotionsModel!
                  .promotions!
                  .cast<SinglePromotion>(),),
            );
          }),
        ),
      ));
      expect(tester.widgetList(find.bySubtype<SinglePromotionItem>()).length, 1);
    });
  });

  group('testing promotions screen', () {
    testWidgets('testing promotions view', (WidgetTester tester) async {
      when(mockPromotionsCubit.promotionsModel).thenReturn(PromotionsModel(
          promotions: <SinglePromotion>[SinglePromotion(validTo: "test",shopName: "test",offerCount: 2,value: "test")]
      ));
      when(mockPromotionsCubit.filters).thenReturn(<FilterItem>[
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
      ]);
      await tester.pumpWidget(BlocProvider<PromotionsCubit>(
        create: (BuildContext context) => mockPromotionsCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: ListOfFiltersBody(
                filters:filters
              )
            );
          }),
        ),
      ));
      expect(tester.widgetList(find.bySubtype<SingleTap>()).length, 2);
    });
  });
}
