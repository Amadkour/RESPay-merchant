import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/card_number_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/cvv_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/expire_date_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/card_limit/card_limit_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/transaction_global_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/credit_card_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/details_card_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/settings_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/tab_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/transaction_history_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/page/cards_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/provider/model/limits_model.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/view/page/card_info_page.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_icon_widget.dart';
import 'package:res_pay_merchant/routes/router.dart';

import '../../core/global_mocks/set_up_test.dart';

@GenerateMocks(<Type>[CardsCubit])
void main() {
  late final List<CreditCardModel> creditCardModels = <CreditCardModel>[
    CreditCardModel(
        uuid: "DSADD",
        id: 1,
        isActive: true,
        cardNumber: "55551111333354444",
        type: "43234",
        holderName: "hussin",
        cvv: 111,
        expiryDate: "01/2027")
  ];
  late CardsCubit cardsCubit;
  late CardLimitCubit cardLimitCubit;
  setUpAll(() {
    mockTest();
    cardsCubit = sl<CardsCubit>();
    cardLimitCubit = sl<CardLimitCubit>();

    when(cardsCubit.creditCardModels).thenReturn(creditCardModels);
    when(cardsCubit.index).thenReturn(0);
    when(cardsCubit.cardNumberFocusNode).thenReturn(FocusNode());
    when(cardsCubit.cvvFocusNode).thenReturn(FocusNode());
    when(cardsCubit.validUntilFocusNode).thenReturn(FocusNode());
    when(cardsCubit.enableCreateCardButton).thenReturn(true);
    when(cardsCubit.date).thenReturn("01/2027");
    when(cardsCubit.nameFocusNode).thenReturn(FocusNode());
    // when(sl<DetailsCardWidget>()..index).thenReturn(0);
    when(cardsCubit.pageViewController).thenReturn(PageController());
    when(cardsCubit.state).thenReturn(CardsInitial());
    when(cardsCubit.tapBarIndex).thenReturn(0);
    when(cardsCubit.lockCard).thenReturn(true);
    when(cardsCubit.enableNFC).thenReturn(true);
    when(cardsCubit.enableOnlinePayments).thenReturn(true);
    when(cardsCubit.enableCardPin).thenReturn(true);
    when(cardsCubit.transactionModels).thenReturn(<TransactionGlobalModel>[
      TransactionGlobalModel(
          id: 1,
          title: "Shopping",
          image: "assets/icons/dummy/export.svg",
          transaction: "-54.00 SAR",
          date: "05 August , 10:00AM"),
      TransactionGlobalModel(
          id: 2,
          title: "Shopping",
          image: "assets/icons/dummy/export.svg",
          transaction: "-54.00 SAR",
          date: "05 August , 10:00AM"),
      TransactionGlobalModel(
          id: 3,
          title: "Shopping",
          image: "assets/icons/dummy/export.svg",
          transaction: "-54.00 SAR",
          date: "05 August , 10:00AM")
    ]);
    when(cardsCubit.cardsVisible).thenReturn(<bool>[true]);
    final Stream<CardsState> stream =
        Stream<CardsState>.fromIterable(<CardsState>[
      CardsInitial(),
      CardsLoading(),
      CardsLoading(),
    ]);
    final Stream<CardLimitState> cardLimitStateStream =
        Stream<CardLimitState>.fromIterable(<CardLimitState>[
      CardLimitInitial(),
    ]);

    when(cardLimitCubit.stream).thenAnswer(
      (Invocation i) => cardLimitStateStream,
    );
    when(cardLimitCubit.state).thenReturn(CardLimitInitial());
    when(cardLimitCubit.transactionLimit).thenReturn(100);
    when(cardLimitCubit.withdrawLimit).thenReturn(200);
    when(cardsCubit.limitsModel).thenReturn(LimitsModel(
        cashbackBalance: "100",
        cashWithdrawLimit: "200",
        limitPerTransaction: "30"));
    when(cardsCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
  });
  group('testing Cards List screen', () {
    testWidgets('testing  Cards List (with other feature in Tap 1) view',
        (WidgetTester tester) async {
      await buildCardsPageBody(tester);
      expect(tester.widgetList(find.byType(PageView)).length, 1);
      expect(tester.widgetList(find.byType(CreditCardWidget)).length, 1);
      expect(tester.widgetList(find.byType(Image)).length, 1);
      expect(find.byKey(const Key("master_card_image")), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('current_balance'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, "3.792.00\$")
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('debit_card_number'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(
                  AutoSizeText,
                  creditCardModels[cardsCubit.index]
                      .cardNumber!
                      .substring(12, 16))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${creditCardModels[cardsCubit.index].cardNumber!.substring(0, 4)}    ')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${creditCardModels[cardsCubit.index].cardNumber!.substring(4, 8)}    ')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${creditCardModels[cardsCubit.index].cardNumber!.substring(8, 12)}    ')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('valid_thru'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${creditCardModels[cardsCubit.index].expiryDate!.split('/')[0]}/${creditCardModels[cardsCubit.index].expiryDate!.split('/')[1].substring(2, 4)}')
              .evaluate()
              .toList()
              .length,
          1);
      expect(tester.widgetList(find.byType(DetailsCardWidget)).length, 1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('detail_cards'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('edit_limit'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('cashback_balance'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(
                  AutoSizeText, '${cardsCubit.limitsModel.cashbackBalance}')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('limit_per_transaction'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${((sl<CardLimitCubit>().transactionLimit * 10).truncate()).toStringAsFixed(0)}.00 ${tr('sar')}')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('cas_withdraw_limit'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText,
                  '${((sl<CardLimitCubit>().withdrawLimit * 10).truncate()).toStringAsFixed(0)}.00 ${tr('sar')}')
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('other_feature'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(tester.widgetList(find.byType(TabWidget)).length, 2);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('settings'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('transaction_history'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(find.byType(SettingsList), findsOneWidget);
      expect(
          find
              .widgetWithText(LoadingButton, tr('delete_card'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(AutoSizeText, tr('add_to_apple_wallet'))
              .evaluate()
              .toList()
              .length,
          1);
    });
    testWidgets('testing  Cards List (with other feature in Tap 2) view',
        (WidgetTester tester) async {
      when(cardsCubit.tapBarIndex).thenReturn(1);
      await buildCardsPageBody(tester);
      expect(tester.widgetList(find.byType(SingleTransactionItem)).length, 3);
    });
    testWidgets('testing  Add New Card Screen', (WidgetTester tester) async {
      await buildAddNewCardPageBody(tester);
      expect(find.text(tr('add_new_credit_card')), findsOneWidget);
      expect(find.text(tr('for_ease_of_transaction')), findsOneWidget);
      expect(tester.widgetList(find.byType(CardIconWidget)).length, 3);
      expect(find.byType(CreditCardNumberTextField), findsOneWidget);
      expect(find.byType(CvvTextField), findsOneWidget);
      expect(find.byType(ExpireDateTextField), findsOneWidget);
      expect(find.byType(NameTextField), findsOneWidget);
      expect(
          find
              .widgetWithText(LoadingButton, tr('save'))
              .evaluate()
              .toList()
              .length,
          1);
    });
  });
}

Future<void> buildCardsPageBody(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
        BlocProvider<GlobalCubit>.value(
          value: sl<GlobalCubit>(),
        ),
      ], child: const CardsPage())));
}

Future<void> buildAddNewCardPageBody(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<GlobalCubit>.value(
              value: sl<GlobalCubit>(),
            ),
          ],
          child: CardInfoPage(
            arguments: <String, dynamic>{
              "callback": () => CustomNavigator.instance.pop(),
            },
          ))));
}
