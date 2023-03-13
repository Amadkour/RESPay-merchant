import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/page/budget_page.dart';
import 'package:res_pay_merchant/routes/router.dart';
import 'budget_page_test.mocks.dart';

@GenerateMocks(<Type>[
  BudgetCubit,
])
void main() {
  late MockBudgetCubit cubit;

  setUpAll(() {
    cubit = MockBudgetCubit();

    final Stream<BudgetState> stream =
        Stream<BudgetState>.fromIterable(<BudgetState>[
      BudgetInitial(),
      BudgetLoading(),
      const BudgetChangeDuration('1'),
      const BudgetSelectCategory(CategoryTypeModel(
          id: 1, name: 'name', icon: '', slug: 'slug', uuid: '')),
      BudgetError(ServerFailure()),
      BudgetCategoriesLoaded(),
      BudgetCategoryAdded(),
      const BudgetCategoryNameChanged(''),
      const BudgetCategoryDeleted(''),
      BudgetAmountChanged(),
      const BudgetCategoryToggle(value: false),
      const BudgetCategoryLoading( uuid: "uuid"),
    ]);

    when(cubit.stream).thenAnswer((Invocation realInvocation) => stream);
    when(cubit.state).thenReturn(BudgetCategoriesLoaded());
    when(cubit.model).thenReturn(BudgetListModel());
    when(cubit.duration).thenReturn("weekly");
  });

  group('Budget Page Test', () {
    testWidgets('Budget Page Test', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<BudgetCubit>(
        create: (BuildContext context) => cubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          onGenerateRoute: (RouteSettings settings) =>
              AppRouter.router(settings),
          home: Scaffold(
            appBar: MainAppBar(
              title: tr('budget'),
            ),
            body: BudgetPageScaffold(
              budgetCubit: cubit,
            ),
          ),
        ),
      ));

      expect(find.text(tr('budget')), findsOneWidget);

      await tester.tap(find.text(tr('add_new')));
      await tester.pumpAndSettle();

      expect(find.text(tr('add_new_category')), findsOneWidget);
    });
  });
}
