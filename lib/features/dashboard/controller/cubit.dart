import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/features/dashboard/controller/state.dart';
import 'package:res_pay_merchant/features/dashboard/provider/model/bottom_navigator_model.dart';
import 'package:res_pay_merchant/features/dashboard/provider/repo.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late List<BottomNavigatorModel> items;

  DashboardCubit() : super(Empty()) {
    currentIndex = 0;
    pageController = PageController();
    items = BottomNavigatorRepo().fetchItems();
  }

  late PageController pageController;
  late int currentIndex;


  void bottomChanged(
    int index,
  ) {
    currentIndex = index;
    pageController.jumpToPage(
      index,
    );
    emit(IndexChanged(index));
  }

  static DashboardCubit get(BuildContext context) => BlocProvider.of(context);
}
